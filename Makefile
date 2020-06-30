VERSION=0.0.1
DESTDIR= 

all: install

install:
	install -m 644 usr/share/66/service/*  "${DESTDIR}"/usr/share/66/service/
	cd "${DESTDIR}"/usr/share/66/service/ && \
		find . -type f -name "*" -print0 | xargs -0 sed -i "s/@VERSION@/${VERSION}/g"

.PHONY: all install
