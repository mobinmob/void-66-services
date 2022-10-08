# 66-void

`66-void` is a package that can replace runit-void and provide the user a voidlinux system that cleanly boots with 66, without any hacks.

## Why?

If a user follows the direction in 66-void-conf.md, they will end with a voidlinux system booted with 66. The system will work and be able to switch between runit and 66 by changing either the kernel commandline, or the init symlink.
That is really nice and flexible, but it comes with a cost. In order to keep both systems working correctly, there are two services, a runit `core-service` named switch-initutils and a 66 frontend service file with the same name.
There change the init utilities (halt, reboot, shutdown, poweroff) to match the running init system/service manager. That is a nice and (mostly) working **hack**.
`66-void` tries to provide a better, cleaner way to use 66, with its own "base" package that fully replaces runit-void.

## How to use

Assuming a user has a **working system with 66**, they only need to install the package:

```
# xbps-install -S 66-void
```
That is it :)

After that, the kernelcommandline **should not have** `init=/usr/bin/66` anymore.

#### Switch back to runit

Switching to runit after installing/using 66-void, is not hard:

1.First remove the 66-void package:

```
# xbps-remove 66-void
```

2.Then, install the runit-void package:

```
# xbps-install runit-void
```

3.Reboot:

```
# /etc/66/reboot
```
#### Switch to using 66 from using runit

If after the previous procedure someone wants to switch again, the procedure is similar:

1.Install 66-void:

```
# xbps-install -S 66-void
```

2.After that, you can reboot with CTRL+ALT+DEL.


## Contents

The package contains all the non-init utilities that exists in the void-runit project. These are:

- vlogger
- zzz
- seedrng
- pause
- modules-load

There are accompanied by their manpages, where these are available in the upstream repository.

There are also the 66 init utilities, namely:

- halt
- reboot
- poweroff
- shutdown

as well as **init**, as a link to `/usr/bin/66`.

Also included are some configuration files:

- /etc/rc.local
- /etc/rc.conf
- /etc/os-release
- /etc/hostname

*66 does not recognise /etc/rc.conf directly, but it can be consumed by the 66boot-rcdotconf utility which reuses the values to configure the boot@system module service*
*66 also does not use rc.local by default, but it can be used by declaring it as the `script_file` in the local-rc service.*
*/etc/os-release and /etc/hostname are part of the os.*

The basic directories and symlinks for runit are also a parta of this package, in order to enable the use of the runit 66 service that reuses runit service scripts on top of 66.

## Future work :

- Currently 66-void does not include support for apparmor. I believe the best place for that is the upstream `boot-66ser` repository and I plan to sent an MR asap :)