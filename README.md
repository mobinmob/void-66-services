# void-66-services
66 service frontends for voidlinux

Most frontends are heavily based on the corresponding services run scripts in 
the [void-packages](https://github.com/void-linux/void-packages) repository 
(BSD-2-Clause license). Some of them are based on the 
[original Obarun services](https://framagit.org/pkg/observice) which are under 
the ISC license.

Service frontends can be placed in:

- */usr/share/66/service/*

This is the default location for packaged services.

- */etc/66/service/* 

This is the default location for administrator services, that override the
default/packaged services with the same name if present.

**conf/**  contains configuration files and scripts for the services.

The services contained in this repository are very much a **work in progress**.
