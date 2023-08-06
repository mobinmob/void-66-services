## 1. 66boot-* utilities

In the boot-66serv package there are three small posix shell scripts that try to make configuration for 66 on voidlinux as easy as possible.
In many cases, running these will be the only step a user needs to get the stage 1 scripts configured correctly.
These are:

1. 66boot-initial-setup
2. 66boot-rcdotconf
3. 66boot-storage-autoconf

### 2.1 66boot-initial-setup

`66boot-initial-setup` is the first script written. 
It can be used to create basic `trees` (boot, default and runit) and enable:

- the `boot@system` module service in the *boot* tree, 
- the `switch-initutils` service in the *default* tree and the 
- `runit` service in the *runit* tree.

The default tree is set as the current tree and the runit tree is configured to run after the default.
 
It also makes certain that the default *boot@system* environment file (configuration) is in the proper path and can be accesed using the `/etc/66rc.conf` symlink.

All that means that `66boot-initial-setup`, besides helping the user with basic configuration, implements a barebones policy for a 66-booted voidlinux system.
This policy is modeled after the current official runit voidlinux policy.
The *boot* tree corresponds roughly to what core-services do, the *default* tree to the default runlevel.

These are all implemented as an external script - the user is not required to use it in order to set their system up and they can choose totaly different tree names, different boot@ instance name etc.

### 2.2 66boot-rcdotconf

After running `66boot-initial-setup` a user is expected to configure their system, either by editing directly `/etc/66rc.conf` or by using `66-env`.
The boot@ service gives the user a lot of power in order to configure the boot process and that is awesome and... dangerous.
Some basic configuration keys correspond to the configurations keys in /etc/rc.conf and these settings can be safely transferred to the new configuration format. That is exactly what `66boot-rcdotconf` does. And in many cases it will be enough to run it in order to configure  the system, by reusing the native voidlinux configuration.
A user can then either continue using rc.conf and re-run the script on configuration changes or gradually learn and take advantag of the new configuration format.

### 2.3 66boot-storage-autoconf

When an option in the `boot@` module service configuration is disabled,the corresponding service script will not run at all. That is a very nice feature that lets a user fine-tune the boot process and avoid execution of what they do not need.
It can also lead to severe problems in boot if needed options are disabled. `66boot-rcdotconf` will check for the validity of some configuration keys when applying configurationf from `/etc/rc.conf`, but there was another area with potential issues.

`boot@` has seperate services for the support of lvm, mdraid, dmraid, luks, zfs, btrfs. In the original implementation enabling one of these if the necessary utilities were not present in the system or even if there were but no storage device of the type was detected, the boot will fail. 
This was... correct, but also **fragile**. `66boot-storage-autoconf` was created to make this area of configuration easier for the user and the boot proccess more robust.

This is accomplised by using `blkid` from `util-linux` to discover the *TYPE* of storage volumes in the system and `66-which` to determine if the corresponding utilities exists. After that, the configuration is written with `66-env` in the environment/configuration file of the boot@system service and any iregularities are pointed out.

## 3. Upstream contributions based on the scripts

These three scripts are in some ways voidlinux-specific:

- `66boot-initial-setup` is implementing policy that is based on the current official voidlinux policy. It does not have much that will help beyond the distribution.
- [`66boot-rcdotconf`](https://codeberg.org/mobinmob/66-voidlinux/commit/721050e92677a728f2c4f4eccf8b8969eb21447d) is tranlating the voidlinux `/etc/rc.conf`, and while they are other distributions with similar configurations it is not certain that translated to exactly the same or compatible implementation.
- `66boot-storage-autoconf` is probably the most distribution-independent of the three. But it still has some aspects - such as package names- that are voidlinux-specific. These are clearly documented in the script comments.

Code and ideas from `66boot-rcdotconf` and `66boot-storage-autoconf` has been used to improve the configure script in the upstream boot@ service. If anyone needs to leard the gory details, they can [read the MR comments](https://git.obarun.org/obmods/boot-66serv/-/merge_requests/1).

## 4. Future work

There is not much to do in adding features to the scripts - they will follow the development off 66. That means that in the next version they will need to be adjusted for the major cli ui changes. 

There will probably be a feature removal for 66boot-initial setup. Creating trees and populating them will be streamlined and the -effective but crude- way to  do that will be obsolete.

There is a plan to reuse code from `66boot-rcdotconf` and `66boot-storage-autoconf` directly in the configure script of the boot@ service. That will enable seemless and automatic configuration for the user by default, with all the power of the full boot@ environment file available.
