#
# Makefile for EPS figures
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

E2E?=eps2eps
EPSTOOL?=epstool
EPSTOPDF?=epstopdf
GS?=gs

E2EFLAGS?=-dSAFER
ETFLAGS?=--quiet --copy --bbox
RES?=600

E2EFILES?=*.eps
E2PFILES?=*.eps
FBBFILES?=*.eps
PDF2PNGFILES?=*.pdf
PDF2TIFFILES?=*.pdf
FIGCLFILES?=*.pdf *.png *.tif
SUFFIX?=~

# end of configuration

help:
	@echo "Targets:"
	@echo "  clean        clean PDF files"
	@echo "  epstoeps     optimize EPS files"
	@echo "  epstopdf     convert all figures to PDF"
	@echo "  pdftopng256  convert PDF to PNG (256-color)"
	@echo "  pdftotiffg4  convert PDF to TIFF (b/w CCITT Group 4)"
	@echo "  fixbb        fix BoundingBox of EPS files"
	@echo "  help         (default) show help"

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

pdftopng256:	$(patsubst %.pdf, %.png, $(wildcard $(PDF2PNGFILES)))

pdftotiffg4:	$(patsubst %.pdf, %.tif, $(wildcard $(PDF2TIFFILES)))

fixbb: $(FBBFILES)
	@for f in $^ ;\
	do \
		echo -n "fixbb: $$f..." ;\
		$(EPSTOOL) $(ETFLAGS) $$f $$f$(SUFFIX) ;\
		mv $$f$(SUFFIX) $$f ;\
		echo "done" ;\
	done

%.pdf:	%.eps
	@echo -n "epstopdf: $^..."
	@$(EPSTOPDF) "$^"
	@echo "done"

%.png:	%.pdf
	@echo -n "pdftopng256: $^..."
	@$(GS) -sDEVICE=png256 -r$(RES) -q -sOutputFile=$(^:.pdf=.png) \
		-dNOPAUSE -dBATCH -dSAFER "$^"
	@echo "done"

%.tif:	%.pdf
	@echo -n "pdftotiffg4: $^..."
	@$(GS) -sDEVICE=tiffg4 -r$(RES) -q -sOutputFile=$(^:.pdf=.tif) \
		-dNOPAUSE -dBATCH -dSAFER "$^"
	@echo "done"
