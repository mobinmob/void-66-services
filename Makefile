
DESTDIR ?= 

all: install

install:
	mkdir -p $(DESTDIR)/usr/share/66/service/
	mv usr/share/66/service/dbus  $(DESTDIR)/usr/share/66/service/
	chmod +x $(DESTDIR)/usr/share/66/service/dbus/check
	install -m 644 usr/share/66/service/*  $(DESTDIR)/usr/share/66/service/

.PHONY: all install
