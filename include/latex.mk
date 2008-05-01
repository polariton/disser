#
# Makefile for LaTeX projects
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET?=thesis

ARCH?=7z
BIBTEX?=bibtex8
DVIPS?=dvips
FIND?=/bin/find
L2H?=latex2html
LATEX?=latex
PDFLATEX?=pdflatex
PS2PDF?=gs
PSBOOK?=psbook
PSNUP?=psnup

ARCHEXT?=zip
ARCHFLAGS?=a -t$(ARCHEXT)
ARCHIVE?=$(TARGET).$(ARCHEXT)
BIBTEXFLAGS?=-H -c cp1251

L2HFLAGS?=-dir html -iso_language RU.RU -split 3 -short_index \
  -numbered_footnotes -no_footnode -white -antialias -html_version 4.0
L2RTFFLAGS?=-F -M12 -i russian
PS2PDFFLAGS?=-dBATCH -dNOPAUSE -sDEVICE=pdfwrite -g4960x7016 -r600 \
  -dCompatibilityLevel=1.2
PSNUPFLAGS?=-2 -pA4
PDFLATEXFLAGS?=--shell-escape
LATEXFLAGS?=-src-specials

CLEXT?=*.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof *.lot *.lol \
  *.bbl *.blg *.bak *.dvi *.ps *.pdf
CLFILES?=$(CLEXT) $(ARCHIVE)
SRCFILES?=*

# end of configuration

dvi: $(TARGET).dvi

pdf: $(TARGET).pdf

pdf_2on1: $(TARGET)_2on1.pdf

pdf_book: $(TARGET)_book.pdf

ps: $(TARGET).ps

ps_2on1: $(TARGET)_2on1.ps

ps_book: $(TARGET)_book.ps

html: $(TARGET).dvi
	$(L2H) $(L2HFLAGS) $(TARGET).tex

rtf: $(TARGET).rtf

$(TARGET).dvi: $(TARGET).tex
	$(LATEX) $(TEXFLAGS) $^
	@if [ -f $(TARGET).bib ];\
	then \
		$(BIBTEX) $(BIBTEXFLAGS) $(TARGET) ;\
		$(LATEX) $(TEXFLAGS) $^ ;\
	else \
		echo Warning: Bibliography file does not exist ;\
	fi
	$(LATEX) $(TEXFLAGS) $^

$(TARGET).ps: $(TARGET).dvi
	$(DVIPS) -o $@ $^

$(TARGET)_2on1.ps: $(TARGET).ps
	$(PSNUP) $(PSNUPFLAGS) $^ > $@

$(TARGET)_book.ps: $(TARGET).ps
	$(PSNUP) $(PSNUPFLAGS) $^ > $@
	$(PSBOOK) $^ | $(PSNUP) -2 > $@

$(TARGET).pdf: $(TARGET).tex
	$(PDFLATEX) $(PDFLATEXFLAGS) $^
	@if [ -f $(TARGET).bib ];\
	then \
		$(BIBTEX) $(BIBTEXFLAGS) $(TARGET) ;\
		$(PDFLATEX) $(PDFLATEXFLAGS) $^ ;\
	else \
		echo Warning: Bibliography file does not exist ;\
	fi
	$(PDFLATEX) $(PDFLATEXFLAGS) $^

$(TARGET)_2on1.pdf: $(TARGET)_2on1.ps
	$(PS2PDF) $(PS2PDFFLAGS) -sOutputFile=$@ -c save pop -f $^

$(TARGET)_book.pdf: $(TARGET)_book.ps
	$(PS2PDF) $(PS2PDFFLAGS) -sOutputFile=$@ -c save pop -f $^

$(TARGET).rtf: $(TARGET).dvi
	$(L2RTF) $(L2RTFFLAGS) -a $(TARGET).aux -b $(TARGET).bbl $(TARGET).tex

epstoeps:
	@$(MAKE) -C fig $@

epstopdf:
	@$(MAKE) -C fig $@

fixbb:
	@$(MAKE) -C fig $@

srcdist:
	@$(MAKE) clean
	$(ARCH) $(ARCHFLAGS) $(ARCHIVE) $(SRCFILES)

clean:
	rm -f $(CLFILES)
	rm -f html/*.*
	@$(MAKE) -C fig $@

help:
	@echo "List of targets:"
	@echo "  dvi        (default) build DVI"
	@echo "  clean      remove output files"
	@echo "  epstoeps   optimize EPS files"
	@echo "  epstopdf   convert figures to PDF"
	@echo "  fixbb      fix BoundingBox of EPS files"
	@echo "  help       show list of targets"
	@echo "  html       convert to HTML"
	@echo "  pdf        build PDF"
	@echo "  pdf_2on1   build PDF with two A5 pages on one A4 ordered by number"
	@echo "  pdf_book   build PDF booklet (two A5 on A4)"
	@echo "  ps         build PS"
	@echo "  ps_2on1    build PS with two A5 pages on one A4 ordered by number"
	@echo "  ps_book    build PS booklet (two A5 on A4)"
	@echo "  rtf        convert to RTF"
	@echo "  srcdist    build source distribution $(ARCHIVE)"

