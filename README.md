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

## Installation

Install the services in your system with :


	# make
or:

	# make install

They will be placed in under */usr/share/66/service/* with the correct *@version*.
To use them see the 66 documentation contained in the *66-doc* package, especially 
the man pages for *66-enable* and *66-disable* commands.

 
