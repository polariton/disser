TARGET=thesis
TEXMF?=/usr/share/texmf
DOCDIR?=$(TEXMF)/doc/latex/disser

dvi ps ps_2on1 pdf pdf_2on1 html clean epstopdf fixbb srcdist all allpdf:
	@$(MAKE) -i -C bachelor $@
	@$(MAKE) -i -C master $@
	@$(MAKE) -i -C candidate $@
	@$(MAKE) -i -C doctor $@

help:
	@$(MAKE) -s -C bachelor $@
	@echo "  install    install templates to TeX tree"
	@echo "  uninstall  uninstall templates"
	@echo "  reinstall  reinstall templates"

install:
	cp -rf ../templates $(DOCDIR)
	cp -rf ../include $(DOCDIR)

uninstall:
	rm -rf $(DOCDIR)/templates
	rm -rf $(DOCDIR)/include
	rmdir $(DOCDIR)

reinstall: uninstall install
