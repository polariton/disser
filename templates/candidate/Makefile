#
# Makefile for documents and templates
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET?=thesis


include ../../include/latex.mk

all:
	@env TARGET=thesis $(MAKE) ;\
	 env TARGET=autoref $(MAKE) ;\
	 eval unset TARGET

allpdf:
	@env TARGET=thesis $(MAKE) pdf ;\
	 env TARGET=autoref $(MAKE) pdf ;\
	 eval unset TARGET

help: .help
	@echo "  all          build DVI of autoref and thesis" ;\
	 echo "  allpdf       build PDF of autoref and thesis" ;\

