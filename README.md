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

The [boot-66serv PR](https://github.com/void-linux/void-packages/pull/25743)
in the void-packages repo contains a template for the lastest void-66-packages
version. Creating a package from that template and installing it is the
preffered method to get the frontend service files.

Additionally, there are templates that create packages from the master or devel
branches of this repo under *packaging/* for anyone who wishes to track development or participate
in it.

When using these packages, frontend service files will be placed in under */usr/share/66/service/*.
To use them see the 66 documentation contained in the *66-doc* package, especially
the man pages for *66-enable* and *66-disable* commands.
