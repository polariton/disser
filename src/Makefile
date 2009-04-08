#
# Makefile for LaTeX packages
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET?=disser
SUBCLASS=gost732
BST=disser-bst
MANUAL?=manual

TEXMF?=/usr/share/texmf
CLSDIR?=$(TEXMF)/tex/latex/$(TARGET)
DOCDIR?=$(TEXMF)/doc/latex/$(TARGET)
BSTDIR?=$(TEXMF)/bibtex/bst/$(TARGET)
BSTDOCDIR?=$(TEXMF)/doc/bibtex/$(TARGET)

CLSFILES?=$(TARGET).cls *.rtx $(SUBCLASS).cls
BSTFILE?=$(TARGET).bst
DOCFILES?=$(TARGET).pdf $(SUBCLASS).pdf $(MANUAL).pdf
BSTDOCFILE?=$(BST).pdf

CLEXT?= *.log *.out *.aux *.dvi *.idx *.ilg *.ind *.glo *.toc *.bak *.bbl *.blg *.sav
CLFILES?=$(CLSFILES) $(BSTFILE) $(DOCFILES) $(BSTDOCFILE) $(CLEXT)

LATEX?=latex
PDFLATEX?=pdflatex
MI?=makeindex

LATEXFLAGS?=
PDFLATEXFLAGS?=

all: class doc

class: *.cls

doc: pdf

dvi: $(TARGET).dvi $(SUBCLASS).dvi $(BST).dvi $(MANUAL).dvi

pdf: $(TARGET).pdf $(SUBCLASS).pdf $(BST).pdf $(MANUAL).pdf

install: all
	mkdir -p $(CLSDIR)
	mkdir -p $(BSTDIR)
	mkdir -p $(DOCDIR)
	mkdir -p $(BSTDOCDIR)
	cp $(CLSFILES) $(CLSDIR)
	cp $(BSTFILE) $(BSTDIR)
	cp $(DOCFILES) $(DOCDIR)
	cp $(BSTDOCFILE) $(BSTDOCDIR)
	ln -s $(BSTDOCDIR)/$(BSTDOCFILE) $(DOCDIR)/$(BSTDOCFILE)
	@echo -e "\nDon't forget to run 'mktexlsr' if you install this class first time\n"

clean:
	rm -f $(CLFILES)

%.cls: %.ins
	$(TEX) $<

%.dvi: %.dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

%.dvi: %.tex
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

%.pdf: %.dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

%.pdf: %.tex
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

