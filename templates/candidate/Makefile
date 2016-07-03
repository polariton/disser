#
# Makefile for documents and templates
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET ?= thesis
BIBTEX ?= bibtex8
BIBTEXFLAGS ?= -H -c cp1251

include ../../include/latex.mk

all:
	@env TARGET=thesis $(MAKE) ;\
	 env TARGET=autoref $(MAKE) ;\
	 eval unset TARGET

allpdf:
	@env TARGET=thesis $(MAKE) pdf ;\
	 env TARGET=autoref $(MAKE) pdf ;\
	 eval unset TARGET

alldvi:
	@env TARGET=thesis $(MAKE) dvi ;\
	 env TARGET=autoref $(MAKE) dvi ;\
	 eval unset TARGET

help: .help
	@echo "  all          build PDF of autoref and thesis" ;\
	 echo "  allpdf       build PDF of autoref and thesis" ;\
	 echo "  alldvi       build DVI of autoref and thesis" ;\
