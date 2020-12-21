
DESTDIR ?= 

all: install

install:
	mkdir -p $(DESTDIR)/usr/share/66/service/
	install -m 644 usr/share/66/service/*  $(DESTDIR)/usr/share/66/service/

.PHONY: all install
