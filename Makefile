#
# Makefile for disser package
# Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>
# 

TARGET=disser
VER?=1.0.5
EXPORTDIR?=$(TARGET)-latest

HG?=hg
REPO?=http://disser.sourceforge.net/hg/disser/

ARCHEXT?=zip
ARCHIVE?=$(TARGET)-$(VER).$(ARCHEXT)

FTPSERVER=upload.sourceforge.net
FTPDIR=incoming

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

update:
	rm -rf $(EXPORTDIR)
	$(HG) clone $(REPO) $(EXPORTDIR)

install:
	@$(MAKE) -i -C src $@

template: 
	@$(MAKE) -i -C templates

sfupload: $(ARCHIVE)
	ncftpput $(FTPSERVER) /$(FTPDIR) $^

srcdist:
	@if [ -f $(ARCHIVE) ];\
	then \
		rm -f $(ARCHIVE);\
	fi

	$(HG) archive -X .hgignore -X .hg_archival.txt -t $(ARCHEXT) \
		$(TARGET).$(ARCHEXT)
	@if [ -f $(TARGET).$(ARCHEXT) ];\
	then \
		mv $(TARGET).$(ARCHEXT) $(ARCHIVE);\
	fi

help:
	@echo "List of targets:"
	@echo "  all        build classes, documentation and templates"
	@echo "  class      (default) build classes and documentation"
	@echo "  clean      remove ouptut files"
	@echo "  doc        build DVI and PDF versions of documentation"
	@echo "  install    install package and documentation"
	@echo "  sfupload   upload source distribution to Sourceforge"
	@echo "  srcdist    create source distribution"
	@echo "  template   build templates"
	@echo "  help       show help"
	@echo "  update     download latest Mercurial repository"
