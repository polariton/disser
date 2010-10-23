#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET := disser
BST := gost705
MAINDTX := $(TARGET) $(BST) gost732
MANUAL := manual

CLSFILES := *.cls *.rtx
BSTFILES := gost705.bst gost705s.bst
CSFFILES := *.csf
DOCFILES := $(addsuffix .pdf, $(MAINDTX) $(MANUAL))
TEXTFILES := ../README ../README.ru ../ChangeLog
SRCFILES := *.dtx $(TARGET).ins dtx.ist $(MANUAL).tex Makefile \
  nomake.cmd

TEXMF ?= /usr/share/texmf
DESTDIR ?= $(TEXMF)
CLSDIR ?= $(DESTDIR)/tex/latex/$(TARGET)
DOCDIR ?= $(DESTDIR)/doc/latex/$(TARGET)
BSTDIR ?= $(DESTDIR)/bibtex/bst/$(TARGET)
CSFDIR ?= $(DESTDIR)/bibtex/csf/$(TARGET)
SRCDIR ?= $(DESTDIR)/source/latex/$(TARGET)

CLEXT ?= *.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof *.lot *.lol \
  *.bbl *.blg *.bak *.dvi *.ps *.pdf
CLFILES ?= $(CLEXT) $(CLSFILES) $(BSTFILES)

LATEX ?= latex
PDFLATEX ?= pdflatex
MI ?= makeindex

LATEXFLAGS ?= --src-specials
PDFLATEXFLAGS ?= --shell-escape
MIFLAGS ?= -r -s dtx.ist


all: package doc

package: $(TARGET).cls

doc: pdf

dvi: $(addsuffix .dvi, $(MAINDTX) $(MANUAL))

pdf: $(DOCFILES)

clean:
	-rm -f $(CLFILES)

install: all
	mkdir -p $(CLSDIR) ;\
	mkdir -p $(BSTDIR) ;\
	mkdir -p $(CSFDIR) ;\
	mkdir -p $(DOCDIR) ;\
	mkdir -p $(SRCDIR) ;\
	cp $(CLSFILES)  $(CLSDIR) ;\
	cp $(BSTFILES)  $(BSTDIR) ;\
	cp $(CSFFILES)  $(CSFDIR) ;\
	cp $(DOCFILES)  $(DOCDIR) ;\
	cp $(TEXTFILES) $(DOCDIR) ;\
	cp $(SRCFILES)  $(SRCDIR)

uninstall:
	-rm $(addprefix $(CLSDIR)/, $(CLSFILES))
	-rm $(addprefix $(BSTDIR)/, $(BSTFILES))
	-rm $(addprefix $(CSFDIR)/, $(CSFFILES))
	-rm $(addprefix $(DOCDIR)/, $(DOCFILES))
	-rm $(addprefix $(DOCDIR)/, $(notdir $(TEXTFILES)))
	-rm $(addprefix $(SRCDIR)/, $(SRCFILES))
	-rmdir $(CLSDIR)
	-rmdir $(BSTDIR)
	-rmdir $(CSFDIR)
	-rmdir $(DOCDIR)
	-rmdir $(SRCDIR)

reinstall: uninstall install

$(TARGET).dvi: $(TARGET).dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) $(MIFLAGS) $(TARGET)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

$(TARGET).pdf: $(TARGET).dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(MI) $(MIFLAGS) $(TARGET)
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

$(BST).dvi: $(BST).dtx
	$(LATEX) $(LATEXFLAGS) $<
	$(MI) $(MIFLAGS) $(BST)
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

$(BST).pdf: $(BST).dtx
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(MI) $(MIFLAGS) $(BST)
	$(PDFLATEX) $(PDFLATEXFLAGS) $<
	$(PDFLATEX) $(PDFLATEXFLAGS) $<

%.cls: %.ins
	$(LATEX) $^

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
	@echo "  all        (default) build package and documentation" ;\
	 echo "  clean      remove output files" ;\
	 echo "  doc        alias for pdf target" ;\
	 echo "  dvi        build documentation in DVI format" ;\
	 echo "  help       show description of targets" ;\
	 echo "  install    install package and documentation" ;\
	 echo "  package    build package" ;\
	 echo "  pdf        build documentation in PDF format" ;\
	 echo "  reinstall  reinstall package and documentation" ;\
	 echo "  uninstall  uninstall package and documentation"
