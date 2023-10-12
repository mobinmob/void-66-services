# void-66-services
66 service frontends for voidlinux

The project contains services in the [66 frontend service file format](https://web.obarun.org/software/66/latest/frontend.html) for use with the Void Linux distribution. The services should work for other linux distributions with minor modifications. There is also some documentation and other information available in the repo. 

The project is licensed under the BSD-2-Clause license, please see the LICENSE file for information. It also contains services copied or derived from other sources - licensing information for these is in the LICENSE-3RD-PARTY file.


Service frontends can be placed in:

- */usr/share/66/service/*

This is the default location for packaged services.

- */etc/66/service/*

This is the default location for administrator services, that override the
default/packaged services with the same name if present.

**conf/**  contains configuration files and scripts for the services.

The services contained in this repository are very much a **work in progress**.

## Installation

The [s6/66 integration PR](https://github.com/void-linux/void-packages/pull/45578)
in the void-packages repo contains a template for the lastest released void-66-packages
version. Creating a package from that template and installing it is the
preferred method to get the frontend service files.

Additionally, there is a template that creates packages from the master
branch of this repo under *packaging/* for anyone who wishes to track development or participate
in it.

When using these packages, frontend service files will be placed in under */usr/share/66/service/*.
To use them see the 66 documentation contained in the *66-doc* package, especially
the man pages for *66-enable* and *66-disable* commands.

## Documentation

Under conf/ one can find some documentation:

- [Small and simple guide to setup 66 booting on voidlinux](https://github.com/mobinmob/void-66-services/blob/master/conf/void-66-conf.md)
- [Guide on reusing runit services with 66](https://github.com/mobinmob/void-66-services/blob/master/conf/void-66-runitsv.md)
- [Information for logging with 66](https://github.com/mobinmob/void-66-services/blob/master/conf/void-66-logging.md)
- [How to use some the 66boot utilites for configuration](https://github.com/mobinmob/void-66-services/blob/master/conf/void-66boot-.md)
- [How to **completely** migrate from runit to 66 and back](https://github.com/mobinmob/void-66-services/blob/master/conf/void-66-base-system.md)
