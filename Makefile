#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET=disser

VER?=1.1.1
HG?=hg
ARCHEXT?=zip
ARCHIVE?=$(TARGET)-$(VER).$(ARCHEXT)
TDSDIR?=../disser-tds
TDSARCHIVE=$(TARGET).tds.$(ARCHEXT)

class:
	@$(MAKE) -i -C src

templates:
	@$(MAKE) -i -C templates

all: class templates

doc:
	@$(MAKE) -i -C src $@

clean install uninstall reinstall:
	@$(MAKE) -i -C src $@
	@$(MAKE) -i -C templates $@

srcdist:
	@if [ -f $(ARCHIVE) ];\
	then \
		rm -f $(ARCHIVE);\
	fi

	$(HG) archive -X .hgignore -X .hg_archival.txt -X .hgtags -t $(ARCHEXT) \
		$(TARGET).$(ARCHEXT)
	@if [ -f $(TARGET).$(ARCHEXT) ];\
	then \
		mv $(TARGET).$(ARCHEXT) $(ARCHIVE);\
	fi

tds:
	mkdir -p $(TDSDIR)
	@env TEXMF=../$(TDSDIR) $(MAKE) -i -C src install
	@env TEXMF=../$(TDSDIR) $(MAKE) -i -C templates install
	7z a -t$(ARCHEXT) -mx=9 $(TDSARCHIVE) $(TDSDIR)/*

help:
	@echo "Targets:"
	@echo "  all        build classes, documentation and templates"
	@echo "  class      (default) build classes and documentation"
	@echo "  clean      remove ouptut files"
	@echo "  doc        build DVI and PDF versions of documentation"
	@echo "  help       show help"
	@echo "  install    install package and documentation"
	@echo "  reinstall  reinstall package and documentation"
	@echo "  srcdist    create source distribution"
	@echo "  template   build templates"
	@echo "  uninstall  uninstall package and documentation"
