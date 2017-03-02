#
# Makefile for documents and templates
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET ?= thesis
TEXMF ?= /usr/share/texmf
DESTDIR ?= $(TEXMF)
DOCDIR ?= $(DESTDIR)/doc/latex/disser

.PHONY: help install uninstall reinstall

dvi clean figclean bmtoeps epstopdf fixbb pdftopng256 pdftotiffg4 ps ps_2on1 pdf pdf_2on1 html srcdist all allpdf:
	@$(MAKE) -i -C bachelor $@
	@$(MAKE) -i -C specialist $@
	@$(MAKE) -i -C master $@
	@$(MAKE) -i -C candidate $@
	@$(MAKE) -i -C doctor $@

help:
	@$(MAKE) -s -C candidate $@ ;\
	echo "  install      install templates" ;\
	echo "  uninstall    uninstall templates" ;\
	echo "  reinstall    reinstall templates"

install:
	cp -rf ../templates $(DOCDIR) ;\
	cp -rf ../templates-utf8 $(DOCDIR) ;\
	cp -rf ../include $(DOCDIR)

uninstall:
	-rm -rf $(DOCDIR)

reinstall: uninstall install
