#
# Makefile for EPS figures
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

BMTOEPS ?= sam2p
E2E ?= eps2eps
EPSTOOL ?= epstool
EPSTOPDF ?= epstopdf
GS ?= gs

BMTOEPSFLAGS ?=
E2EFLAGS ?= -dSAFER -dNOCACHE
ETFLAGS ?= --quiet --copy --bbox
RES ?= 600

BMTOEPSFILES ?= $(wildcard *.jpg *.png *.tif)
E2PFILES ?= *.eps
FBBFILES ?= *.eps
FIGCLFILES ?= *.pdf *.jpg *.png *.tif
OPTFILES ?= *.eps
PDF2PNGFILES ?= *.pdf
PDF2TIFFILES ?= *.pdf
PREFIX ?= ~


help:
	@echo "  bmtoeps      convert bitmap images to EPS format" ;\
	 echo "  clean        remove output files" ;\
	 echo "  epstoeps     alias for optimize target" ;\
	 echo "  epstopdf     convert EPS to PDF" ;\
	 echo "  fixbb        fix BoundingBox of EPS files" ;\
	 echo "  help         show description of targets" ;\
	 echo "  optimize     optimize EPS files (implies fixbb)" ;\
	 echo "  pdftopng256  convert PDF to PNG (256-color)" ;\
	 echo "  pdftotiffg4  convert PDF to TIFF (b/w CCITT Group 4)"

bmtoeps: $(BMTOEPSFILES)
	@for f in $^ ; do \
		echo "bmtoeps: $$f" ;\
		$(BMTOEPS) $(BMTOEPSFLAGS) "$$f" "$${f%.*}.eps" > /dev/null 2>&1 ;\
	done

clean:
	-rm -f $(FIGCLFILES)

epstoeps: optimize

epstopdf: $(patsubst %.eps, %.pdf, $(wildcard $(E2PFILES)))

fixbb: $(FBBFILES)
	@for f in $^ ; do \
		echo "fixbb: $$f" ;\
		$(EPSTOOL) $(ETFLAGS) "$$f" "$(PREFIX)$$f" ;\
		mv "$(PREFIX)$$f" "$$f" ;\
	done

optimize: $(OPTFILES)
	@for f in $^ ; do \
		echo -n "optimize: $$f" ;\
		$(E2E) $(E2EFLAGS) "$$f" "$(PREFIX)$$f" ;\
		$(EPSTOOL) $(ETFLAGS) "$(PREFIX)$$f" "$(PREFIX)1$$f" ;\
		mv "$(PREFIX)1$$f" "$(PREFIX)$$f" ;\
		if [ `stat -c%s $$f` -gt `stat -c%s $(PREFIX)$$f` ] ; then \
			mv "$(PREFIX)$$f" "$$f" ;\
			echo -en "\n" ;\
		else \
			rm "$(PREFIX)$$f" ;\
			echo " does not need optimization" ;\
		fi ;\
	done

pdftopng256: $(patsubst %.pdf, %.png, $(wildcard $(PDF2PNGFILES)))

pdftotiffg4: $(patsubst %.pdf, %.tif, $(wildcard $(PDF2TIFFILES)))

%.pdf: %.eps
	@echo "epstopdf: $^" ;\
	$(EPSTOPDF) "$^"

%.png: %.pdf
	@echo "pdftopng: $^" ;\
	$(GS) -sDEVICE=png256 -r$(RES) -q -sOutputFile=$(^:.pdf=.png) \
		-dNOPAUSE -dBATCH -dSAFER "$^"

%.tif: %.pdf
	@echo "pdftotiffg4: $^" ;\
	$(GS) -sDEVICE=tiffg4 -r$(RES) -q -sOutputFile=$(^:.pdf=.tif) \
		-dNOPAUSE -dBATCH -dSAFER "$^"

