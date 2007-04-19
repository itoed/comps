XMLINFILES=$(wildcard *.xml.in)
XMLFILES = $(patsubst %.xml.in,%.xml,$(XMLINFILES))

all: po $(XMLFILES)

po: $(XMLINFILES)
	make -C po -f Makefile || exit 1

clean:
	@rm -fv *~

comps-fe7.xml.in: comps-f7.xml.in
	ln -s comps-f7.xml.in comps-fe7.xml.in

%.xml: %.xml.in
	./update-comps $@
	@if [ "$@" == "$(RAWHIDECOMPS)" ] ; then \
		cat $(RAWHIDECOMPS) | sed 's/redhat-release/rawhide-release/g' > comps-rawhide.xml ; \
	fi
