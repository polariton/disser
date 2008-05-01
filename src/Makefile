#
# Makefile for LaTeX packages
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET=disser
SUBCLASS=gost732
TEXMF=/usr/share/texmf
DESTDIR=$(TEXMF)/tex/latex/$(TARGET)
DOCDIR=$(TEXMF)/doc/latex/$(TARGET)

LATEX=latex
PDFLATEX=pdflatex
MI=makeindex

LATEXFLAGS=
PDFLATEXFLAGS=

INSTFILES=*.cls *.rtx
DOCFILES=*.dvi *.pdf *.ps
CLEXT= *.log *.out *.aux *.dvi *.idx *.ilg *.ind *.glo *.toc *.bak *.bbl *.blg *.sav
CLFILES=$(INSTFILES) $(DOCFILES) $(CLEXT)

all: class doc

class: *.cls

doc: dvi pdf

dvi: $(TARGET).dvi $(SUBCLASS).dvi

pdf: $(TARGET).pdf $(SUBCLASS).pdf

install: all
	mkdir -p $(DESTDIR)
	mkdir -p $(DOCDIR)
	cp $(INSTFILES) $(DESTDIR)
	cp $(DOCFILES) $(DOCDIR)

clean:
	rm -f $(CLFILES)

%.cls: %.ins
	$(TEX) $<

%.dvi: %.dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

%.pdf: %.dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

help:
	@echo "List of targets:"
	@echo "  all       (default) build classes and documentation"
	@echo "  class     build classes"
	@echo "  clean     remove ouptut files"
	@echo "  doc       build DVI and PDF versions of documentation"
	@echo "  dvi       build DVI version of documentation"
	@echo "  pdf       build PDF version of documentation"
	@echo "  install   install package and documentation"
	@echo "  help      show help"

