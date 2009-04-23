#
# Makefile for LaTeX projects
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET?=thesis
BIBFILE?=thesis.bib

ARCH?=7z
BIBTEX?=bibtex8
DVIPS?=dvips
L2H?=latex2html
L2RTF?=latex2rtf
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
  -numbered_footnotes -white -antialias -html_version 4.0
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

clean:
	rm -f $(CLFILES)
	@$(MAKE) -C fig $@

epstoeps epstopdf fixbb pdftopng256 pdftotiffg4:
	@$(MAKE) -C fig $@

html: $(TARGET).dvi
	$(L2H) $(L2HFLAGS) $(TARGET).tex

pdf: $(TARGET).pdf

pdf_2on1: $(TARGET)_2on1.pdf

pdf_book: $(TARGET)_book.pdf

ps: $(TARGET).ps

ps_2on1: $(TARGET)_2on1.ps

ps_book: $(TARGET)_book.ps

rtf: $(TARGET).rtf

srcdist: clean
	$(ARCH) $(ARCHFLAGS) $(ARCHIVE) $(SRCFILES)

$(TARGET).dvi: $(TARGET).tex
	$(LATEX) $(TEXFLAGS) $^
	@if [ -f $(BIBFILE) ]; then \
		for f in *.aux; do $(BIBTEX) $(BIBTEXFLAGS) $$f; done ;\
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
	@if [ -f $(BIBFILE) ];\
	then \
		for f in *.aux; do $(BIBTEX) $(BIBTEXFLAGS) $$f ; done ;\
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

help:
	@echo "  dvi       (default) build DVI"
	@echo "  clean     remove output files"
	@echo "  help      show description of targets"
	@echo "  html      convert DVI to HTML"
	@echo "  pdf       build PDF"
	@echo "  pdf_2on1  build PDF with two A5 pages on one A4 ordered by number"
	@echo "  pdf_book  build PDF booklet (two A5 on A4)"
	@echo "  ps        build PS"
	@echo "  ps_2on1   build PS with two A5 pages on one A4 ordered by number"
	@echo "  ps_book   build PS booklet (two A5 on A4)"
	@echo "  rtf       convert DVI to RTF"
	@echo "  srcdist   build source distribution"
