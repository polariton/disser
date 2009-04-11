TARGET=disser
DOCDIR?=$(TEXMF)/doc/latex/$(TARGET)

dvi ps ps_2on1 pdf pdf_2on1 html clean epstopdf fixbb srcdist all allpdf:
	@$(MAKE) -i -C bachelor $@
	@$(MAKE) -i -C master $@
	@$(MAKE) -i -C candidate $@
	@$(MAKE) -i -C doctor $@

help:
	@$(MAKE) -C bachelor $@

install:
	cp -rf ../templates $(DOCDIR)
	cp -rf ../include $(DOCDIR)