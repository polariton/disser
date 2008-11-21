#
# Makefile for LaTeX packages
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET?=disser
SUBCLASS=gost732
BST=disser-bst

TEXMF?=/usr/share/texmf
CLSDIR?=$(TEXMF)/tex/latex/$(TARGET)
DOCDIR?=$(TEXMF)/doc/latex/$(TARGET)
BSTDIR?=$(TEXMF)/bibtex/bst/$(TARGET)
BSTDOCDIR?=$(TEXMF)/doc/bibtex/$(TARGET)

CLSFILES?=$(TARGET).cls *.rtx $(SUBCLASS).cls
BSTFILES?=$(TARGET).bst
DOCFILES?=$(TARGET).dvi $(SUBCLASS).dvi $(TARGET).pdf $(SUBCLASS).pdf
BSTDOCFILES?=$(BST).dvi $(BST).pdf

CLEXT?= *.log *.out *.aux *.dvi *.idx *.ilg *.ind *.glo *.toc *.bak *.bbl *.blg *.sav
CLFILES?=$(CLSFILES) $(BSTFILES) $(DOCFILES) $(CLEXT)

LATEX?=latex
PDFLATEX?=pdflatex
MI?=makeindex

LATEXFLAGS?=
PDFLATEXFLAGS?=

all: class doc

class: *.cls

doc: dvi pdf

dvi: $(TARGET).dvi $(SUBCLASS).dvi $(BST).dvi

pdf: $(TARGET).pdf $(SUBCLASS).pdf $(BST).pdf

install: all
	mkdir -p $(CLSDIR)
	mkdir -p $(BSTDIR)
	mkdir -p $(DOCDIR)
	mkdir -p $(BSTDOCDIR)
	cp $(CLSFILES) $(CLSDIR)
	cp $(BSTFILES) $(BSTDIR)
	cp $(DOCFILES) $(DOCDIR)
	cp $(BSTDOCFILES) $(BSTDOCDIR)

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

