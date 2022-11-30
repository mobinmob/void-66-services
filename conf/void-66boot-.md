## 1. 66boot-* utilities

In the boot-66serv package there are three sh scripts that try to make configurations for 66 on voidlinux as easy as possible.
In many cases these will be the only configuration a user needs to get the stage 1 scripts configured correctly.
These are:
1. 66boot-initial-setup
2. 66boot-rcdotconf
3. 66boot-storage-autoconf

### 2.1 66boot-initial-setup

`66boot-initial-setup` is the first script written. 
It created basic `trees` (boot, default and runit) and enables:
- the `boot@system` module service in the *boot* tree, 
- the `switch-initutils` service in the *default* tree and the 
- `runit` service in the *runit* tree.

The default tree is set as the current tree and the runit tree is configured to run after the default.
 
It also makes certain that the default *boot@system* environment file (configuration) is in the proper path and can be acceses using the `/etc/66rc.conf` symlink.

All that means that `66boot-initial-setup`, besides helping the user with basic configuration, implements a barebones policy for a 66-booted voidlinux system.
This policy is modeled after the current official runit voidlinux policy.
The *boot* tree corresponds roughly to what core-services do, the *default* tree to the default runlevel.

These are all implemented as an external script - the user is not required to use it in order to set their system up and they can choose totaly different tree names, different boot@ instance name etc.

### 2.2 66boot-rcdotconf

After running `66boot-initial-setup` a user is expected to configure their system, either by editing directly /etc/66rc.conf or by using `66-env`.
The boot@ service gives the user a lot of power in order to configure the boot process and that is awesome and... dangerous.
Some basic configuration keys correspond to the configurations keys in /etc/rc.conf and these settings can be safely transferred to the new configuration format. That is exactly what `66boot-rc.conf` does. And in many cases it will be enough to run it in order to configure  the system.
A user can then either continue using rc.conf and re-run the script on configuration changes or gradually learn the new configuration.

### 2.3 66boot-storage-autoconf

