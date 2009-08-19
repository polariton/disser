#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET=disser
SUBCLASS=gost732
BST=disser-bst
MANUAL=manual

CLSFILES=$(TARGET).cls *.rtx $(SUBCLASS).cls
BSTFILES=$(TARGET).bst $(TARGET)-s.bst
DOCFILES=$(TARGET).pdf $(SUBCLASS).pdf $(BST).pdf $(MANUAL).pdf
TEXTFILES=../README ../README.ru ../ChangeLog
SRCFILES=*.dtx *.ins $(MANUAL).tex

TEXMF?=/usr/share/texmf

CLSDIR?=$(TEXMF)/tex/latex/$(TARGET)
DOCDIR?=$(TEXMF)/doc/latex/$(TARGET)
BSTDIR?=$(TEXMF)/bibtex/bst/$(TARGET)
SRCDIR?=$(TEXMF)/source/latex/$(TARGET)

CLEXT?=*.log *.out *.aux *.dvi *.idx *.ilg *.ind *.glo *.toc *.bak *.bbl *.blg *.sav
CLFILES?=$(CLSFILES) $(BSTFILE) $(DOCFILES) $(CLEXT)

LATEX?=latex
PDFLATEX?=pdflatex
MI?=makeindex

LATEXFLAGS?=
PDFLATEXFLAGS?=

all: package doc

package: $(TARGET).ins
	$(LATEX) $^

doc: pdf

dvi: $(TARGET).dvi $(SUBCLASS).dvi $(BST).dvi $(MANUAL).dvi

pdf: $(TARGET).pdf $(SUBCLASS).pdf $(BST).pdf $(MANUAL).pdf

install: all
	mkdir -p $(CLSDIR)
	mkdir -p $(BSTDIR)
	mkdir -p $(DOCDIR)
	mkdir -p $(SRCDIR)
	cp $(CLSFILES)  $(CLSDIR)
	cp $(BSTFILES)  $(BSTDIR)
	cp $(DOCFILES)  $(DOCDIR)
	cp $(TEXTFILES) $(DOCDIR)
	cp $(SRCFILES)  $(SRCDIR)

uninstall:
	rm $(addprefix $(CLSDIR)/, $(CLSFILES))
	rm $(addprefix $(BSTDIR)/, $(BSTFILES))
	rm $(addprefix $(DOCDIR)/, $(DOCFILES))
	rm $(addprefix $(DOCDIR)/, $(notdir $(TEXTFILES)))
	rm $(addprefix $(SRCDIR)/, $(SRCFILES))
	rmdir $(CLSDIR)
	rmdir $(BSTDIR)
	rmdir $(DOCDIR)
	rmdir $(SRCDIR)

reinstall: uninstall install

clean:
	rm -f $(CLFILES)

disser.dvi: disser.dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

disser.pdf: disser.dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(MI) -r $(TARGET)
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

%.dvi: %.dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

%.dvi: %.tex
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

%.pdf: %.dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

%.pdf: %.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

help:
	@echo "  all        (default) build package files and documentation"
	@echo "  clean      remove output files"
	@echo "  doc        build documentation in DVI and PDF formats"
	@echo "  dvi        build documentation in DVI format"
	@echo "  help       show description of targets"
	@echo "  install    install package and documentation"
	@echo "  package    build package"
	@echo "  pdf        build documentation in PDF format"
	@echo "  reinstall  reinstall package and documentation"
	@echo "  uninstall  uninstall package and documentation"
