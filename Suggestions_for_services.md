# Suggestions for Services

This document contains some suggestions on how to build frontend service
files for this repository and how to contribute them. They do not cover what the
[official documentation](https://web.obarun.org/software/66/frontend.html) does,
but are common sense rules for frontend building.

There is not one true way to build frontends as the format is quite flexible and
different policies and preferences will result in different practices.

1. @execute scripts should be written in execline or sh. The former is preferred
but not mandatory. When somebody writes in sh, they must take  [the differences
expressed in the documentation](https://web.obarun.org/software/66/frontend.html#A%20word%20about%20the%20@execute%20key) into account.
2. @execute should contain the necessary setup and **only** the minimum command
switches for the service to run (e.g. to keep it in the foreground).
3. Every other switch should be under [environment] in *cmd_args* or other proper
variables.
4. *cmd_args* replaces *$OPTS* in scripts based on runit services.
5. [stop] section replaces the *finish* script of runit services. Other than
that, [stop] may be used only if  it is needed or it would substantially
improve the service. 
6. Obarun frontend files are obviously a fantastic source of information. Please
be aware that sometimes the policies and/or assumptions of obarun are very
different than those of voidlinux.
7. Do not include configuration file paths or change default configuration
files with variables in [environment].
8. Every new frontend service file is released originally with a @version value of 0.0.1 and
is incremented in the following releases only if there a change.
9. When using execline syntax in @execute, @build=auto may be ommited.
10. Try to keep frontend service files compact, simple and easy to understand.
A user can always customise them and put the customised version in /etc/66/service.
11. Development happens in a development branch. We create PRs against it.The
current development branch is _devel_.
