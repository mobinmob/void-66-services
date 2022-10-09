# 1. base-system-66 and 66-void packages

- `66-void` is a package that can replace `runit-void` and provide the user a voidlinux system that cleanly boots with 66, without any hacks.

- `base-system-66` is a packages that can replace `base-system` and work with `66-void`

## 1.1 Why?

If a user follows the direction in 66-void-conf.md, they will end with a voidlinux system booted with 66. The system will work and be able to switch between runit and 66 by changing either the kernel commandline, or the init symlink.
That is really nice and flexible, but it comes with a cost. In order to keep both systems working correctly, there are two services, a runit `core-service` named switch-initutils and a 66 frontend service file with the same name.
There change the init utilities (halt, reboot, shutdown, poweroff) to match the running init system/service manager. That is a nice and (mostly) working **hack**.
`66-void` tries to provide a better, cleaner way to use 66, with its own "base" package that fully replaces runit-void.

`void-base-66` is a way to complete the transormation to a fully 66-based system. The only functional difference from the upstream official template is that `66-void` has replaces `runit-void` in the depends array.

## 2. How to use 66-void

Assuming a user has a **working system with 66**, they only need to install the package:

```
# xbps-install -S 66-void
```
That is it :)

After that, the kernelcommandline **should not have** `init=/usr/bin/66` anymore.

#### 2.1 Switch back to runit

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
#### 2.2 Switch to using 66 from using runit

If after the previous procedure someone wants to switch again, the procedure is similar:

1.Install 66-void:

```
# xbps-install -S 66-void
```

2.After that, you can reboot with CTRL+ALT+DEL.

## 3. How to use base-system-66

To complete the transformation to fully 66-based system, just install the package.

````
# xbps-install -S base-system-66
````

## 4. `66-void` package contents

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