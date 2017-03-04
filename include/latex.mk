#
# Makefile for LaTeX projects
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET ?= thesis
BIBFILE ?= thesis.bib

ARCH ?= 7z
BIBTEX ?= bibtex8
DVIPS ?= dvips
L2H ?= latex2html
L2RTF ?= latex2rtf
LATEX ?= latex
PDFLATEX ?= pdflatex
PS2PDF ?= gs
PSBOOK ?= psbook
PSNUP ?= psnup
MAKEINDEX ?= makeindex

ARCHEXT ?= zip
ARCHFLAGS ?= a -t$(ARCHEXT)
ARCHIVE := $(TARGET).$(ARCHEXT)
BIBTEXFLAGS ?= -H -c cp1251
DVIPSFLAGS ?= -P pdf -t A4 -z
L2HFLAGS ?= -dir html -iso_language RU.RU -split 3 -short_index \
  -numbered_footnotes -white -antialias -html_version 4.0
L2RTFFLAGS ?= -F -M12 -i russian
LATEXFLAGS ?= --src-specials
PS2PDFFLAGS ?= -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -g4960x7016 -r600 \
  -dCompatibilityLevel=1.2
PSNUPFLAGS ?= -2 -pA4
PDFLATEXFLAGS ?= --shell-escape --synctex=1

CLEXT ?= *.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof *.lot *.lol \
  *.bbl *.blg *.bak *.dvi *.ps *.pdf *.synctex *.synctex.gz *.run.xml *.bcf *.nlo *.nls
CLFILES ?= $(CLEXT) $(ARCHIVE)
SRCFILES ?= *


pdf: $(TARGET).pdf

pdf_2on1: $(TARGET)_2on1.pdf

pdf_book: $(TARGET)_book.pdf

dvi: $(TARGET).dvi

clean:
	-rm -f $(CLFILES)

.help:
	@echo "  dvi          build DVI" ;\
	echo "  figclean     clean output files in figures directory" ;\
	echo "  html         convert DVI to HTML" ;\
	echo "  pdf          (default) build PDF" ;\
	echo "  pdf_2on1     build PDF with two A5 pages on one A4 ordered by number" ;\
	echo "  pdf_book     build PDF booklet (two A5 on A4)" ;\
	echo "  ps           build PS" ;\
	echo "  ps_2on1      build PS with two A5 pages on one A4 ordered by number" ;\
	echo "  ps_book      build PS booklet (two A5 on A4)" ;\
	echo "  rtf          convert DVI to RTF" ;\
	echo "  srcdist      build source distribution" ;\
	$(MAKE) -s -C fig help

html: $(TARGET).dvi
	$(L2H) $(L2HFLAGS) $(TARGET).tex

ps: $(TARGET).ps

ps_2on1: $(TARGET)_2on1.ps

ps_book: $(TARGET)_book.ps

rtf: $(TARGET).rtf

srcdist: clean figclean
	$(ARCH) $(ARCHFLAGS) $(ARCHIVE) $(SRCFILES)

$(TARGET).dvi: *.tex *.bib
	@$(LATEX) $(TEXFLAGS) $(TARGET).tex ;\
	if [ -f $(BIBFILE) ] ; then \
		for f in *.aux; do $(BIBTEX) $(BIBTEXFLAGS) $${f%.*} ; done ;\
	else \
		echo Warning: Bibliography file does not exist ;\
	fi ;\
	if [ -f $(TARGET).nlo ] ; then \
		$(MAKEINDEX) $(TARGET).nlo -s nomencl.ist -o $(TARGET).nls
	fi ;\
	$(LATEX) $(TEXFLAGS) $(TARGET).tex ;\
	$(LATEX) $(TEXFLAGS) $(TARGET).tex

$(TARGET).ps: $(TARGET).dvi
	$(DVIPS) $(DVIPSFLAGS) $^

$(TARGET)_2on1.ps: $(TARGET).ps
	$(PSNUP) $(PSNUPFLAGS) $^ > $@

$(TARGET)_book.ps: $(TARGET).ps
	$(PSNUP) $(PSNUPFLAGS) $^ > $@ ;\
	$(PSBOOK) $^ | $(PSNUP) -2 > $@

$(TARGET).pdf: *.tex *.bib
	@$(PDFLATEX) $(PDFLATEXFLAGS) $(TARGET).tex ;\
	if [ -f $(BIBFILE) ] ; then \
		for f in *.aux ; do $(BIBTEX) $(BIBTEXFLAGS) $${f%.*} ; done ;\
	else \
		echo "Warning: Bibliography file does not exist" ;\
	fi ;\
	if [ -f $(TARGET).nlo ] ; then \
		$(MAKEINDEX) $(TARGET).nlo -s nomencl.ist -o $(TARGET).nls ;\
	fi ;\
	$(PDFLATEX) $(PDFLATEXFLAGS) $(TARGET).tex ;\
	$(PDFLATEX) $(PDFLATEXFLAGS) $(TARGET).tex

$(TARGET)_2on1.pdf: $(TARGET)_2on1.ps
	$(PS2PDF) $(PS2PDFFLAGS) -sOutputFile=$@ -c save pop -f $^

$(TARGET)_book.pdf: $(TARGET)_book.ps
	$(PS2PDF) $(PS2PDFFLAGS) -sOutputFile=$@ -c save pop -f $^

$(TARGET).rtf: $(TARGET).dvi
	$(L2RTF) $(L2RTFFLAGS) -a $(TARGET).aux -b $(TARGET).bbl $(TARGET).tex

%.nls: %.nlo
	$(MAKEINDEX) $< -s nomencl.ist -o $@

bmtoeps epstoeps epstopdf fixbb optimize pdftopng256 pdftotiffg4:
	@$(MAKE) -C fig $@

figclean:
	@$(MAKE) -C fig clean
