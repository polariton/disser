#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET=disser

VER?=1.1.0
HG?=hg
ARCHEXT?=zip
ARCHIVE?=$(TARGET)-$(VER).$(ARCHEXT)

class:
	@$(MAKE) -i -C src

all:
	@$(MAKE) -i -C src
	@$(MAKE) -i -C templates

clean:
	@$(MAKE) -i -C src $@
	@$(MAKE) -i -C templates $@

doc:
	@$(MAKE) -i -C src $@

install:
	@$(MAKE) -i -C src $@

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

template:
	set target=thesis
	@$(MAKE) -i -C templates

help:
	@echo "List of targets:"
	@echo "  all        build classes, documentation and templates"
	@echo "  class      (default) build classes and documentation"
	@echo "  clean      remove ouptut files"
	@echo "  doc        build DVI and PDF versions of documentation"
	@echo "  install    install package and documentation"
	@echo "  srcdist    create source distribution"
	@echo "  template   build templates"
	@echo "  help       show help"
