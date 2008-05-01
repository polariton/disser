#
# Makefile for EPS figures
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

E2E?=eps2eps
EPSTOOL?=epstool
EPSTOPDF?=epstopdf

E2EFLAGS?=-dSAFER
ETFLAGS?=--quiet --copy --bbox

E2EFILES?=*.eps
E2PFILES?=*.eps
FBBFILES?=*.eps
FIGCLFILES?=*.pdf
SUFFIX?=~

# end of configuration

help:
	@echo "Targets:"
	@echo "  clean      clean PDF files"
	@echo "  epstoeps   optimize EPS files"
	@echo "  epstopdf   convert all figures to PDF"
	@echo "  fixbb      fix BoundingBox of EPS files"
	@echo "  help       (default) show help"

clean:
	rm -f $(FIGCLFILES)

epstoeps: $(E2EFILES)
	@for f in $^ ;\
	do \
		echo -n "fixbb: $$f..." ;\
		$(E2E) $(E2EFLAGS) $$f $$f$(SUFFIX) ;\
		mv $$f$(SUFFIX) $$f ;\
		echo "done" ;\
	done

epstopdf:	$(patsubst %.eps, %.pdf, $(wildcard $(E2PFILES)))

fixbb: $(FBBFILES)
	@for f in $^ ;\
	do \
		echo -n "fixbb: $$f..." ;\
		$(EPSTOOL) $(ETFLAGS) $$f $$f$(SUFFIX) ;\
		mv $$f$(SUFFIX) $$f ;\
		echo "done" ;\
	done

%.pdf:	%.eps
	@echo -n "epstopdf: $<..."
	@$(EPSTOPDF) "$<"
	@echo "done"
