Changes
=

 *This file contains the most important changes for each release of the project. It is not meant to be a list of every change as that can be obtained by `git log`. It is also not documentation for every change.*

0.0.3 (not released yet)
=
- More work to have services log to the per-service logger instead of syslog.
- Add a changelog.
- Split licensing information  (LICENSE - LICENSE-3RD-PARTY) and amend the README.md accordingly.
- Repo-wide: remove unneeded @options key, standardise layout a little.
- Create additional service frontend files for nginx, dhcpcd and dhcpcd@ that use pid namespaces though 66-ns.
These frontends have the suffix _ns after the service name.
- All services are represented now by either a single frontend file or a single directory with necessary files/subdirs.
- Documentation:
    - Add simple logging documentation in conf/void-66-logging.md.
    - Add information about the new 66boot-* utilities in conf/void-66-conf.md
    - Change Suggestions_for_services.md to point to the master branch as the development branch.


[0.0.2](https://github.com/mobinmob/void-66-services/releases/tag/v0.0.2) || 2021-02-15
=
-   95 services in total!
- Packaging templates  are created for the master and devel branches under _packaging/_ and the Makefile is removed. The new templates should used by anyone that wants to install the contents of the branches to test new services or contribute to the repo.
- Basic configuration instructions to get 66 running on voidlinux can be found in  conf/void-66-conf.md. That is not installed -yet- by the templates, as a decision needs to be made for the final format. 
- First use of the [66-ns](https://web.obarun.org/software/66-tools/v0.0.7.1/66-ns.html) namespace tool. I expect that more services will be enhanced or even new ones created with namespace support.
- First use of polling for readiness notification in the dbus service, solves a lot of issues. It follows the void service and the approach was first used by @st3r4g in the [void-s6](https://github.com/st3r4g/void-s6) repo.

[0.0.1](https://github.com/mobinmob/void-66-services/releases/tag/v0.0.1) - First release || 2020-12-28
=
- 77 services!
- Many thanks to @teldra, @flexibeast and @Obarun!
