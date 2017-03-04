#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
#

TARGET := disser

VER ?= 1.5.0
GIT ?= git
ARCHEXT ?= zip
ARCHIVE := $(TARGET)-$(VER).$(ARCHEXT)
EXCLUDEFILES := .gitignore
TDSDIR ?= ../$(TARGET)-tds
TDSARCHIVE := $(TARGET)-$(VER).tds.$(ARCHEXT)

.PHONY: package doc templates all clean install uninstall reinstall srcdist tds help

package doc:
	@$(MAKE) -i -C src $@

templates:
	@$(MAKE) -i -C templates
	@$(MAKE) -i -C templates-utf8

all: package templates

clean install uninstall reinstall:
	@$(MAKE) -i -C src $@
	@$(MAKE) -i -C templates $@
	@$(MAKE) -i -C templates-utf8 $@

srcdist:
	@[ -f $(ARCHIVE) ] && rm -f $(ARCHIVE) ;\
	$(GIT) archive --format=$(ARCHEXT) --output=$(ARCHIVE) -9 HEAD ;\
	7z d $(ARCHIVE) $(EXCLUDEFILES)

tds:
	@[ -f $(TDSARCHIVE) ] && rm -f $(TDSARCHIVE) ;\
	[ -d $(TDSDIR) ] && rm -rf $(TDSDIR) ;\
	mkdir -p $(TDSDIR) ;\
	env DESTDIR=../$(TDSDIR) $(MAKE) -i -C src install ;\
	env DESTDIR=../$(TDSDIR) $(MAKE) -i -C templates install ;\
	env DESTDIR=../$(TDSDIR) $(MAKE) -i -C templates-utf8 install ;\
	7z a -t$(ARCHEXT) -mx=9 $(TDSARCHIVE) $(TDSDIR)/*

help:
	@echo "  all        build classes, documentation and templates" ;\
	 echo "  clean      remove output files" ;\
	 echo "  doc        build DVI and PDF versions of documentation" ;\
	 echo "  help       show description of targets" ;\
	 echo "  install    install package and documentation" ;\
	 echo "  package    (default) build package and documentation" ;\
	 echo "  reinstall  reinstall package and documentation" ;\
	 echo "  srcdist    create source distribution" ;\
	 echo "  tds        create TDS archive with compiled sources" ;\
	 echo "  template   build templates" ;\
	 echo "  uninstall  uninstall package and documentation"
