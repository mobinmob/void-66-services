## 1. Void-specific utilities and changes

During the packaging and integration work for 66 and boot-66serv for voidlinux, differences between the original 66-based distribution (obarun, based on arch linux) were adressed by adjusting the sw and writing some utility scripts. These are documented bellow.
I **realy** want to stress that point that this is *by no means* a criticism of the upstream choices, but rather a way to adress differences between the systems. Generally speaking 66 and boot@ are distro agnostic.
 
### 2. Differences of implementation and policy

There are 4 differences that needed adressing in the voidlinux integration work:
1. tmpfiles support
2. systemctl options handling
3. modules handling and 
4. efivarfs mounting.

#### 2.1 tmpfiles.d

Obarun reuses archlinux packaging work and that means it needs an implementation of tmpfiles.d and sysusers.d de-facto standards. The later holds no significance for the init work, but tmpfiles.d had an implementation (based on opentmpfiles) and still has a service in boot@ and an assosiated option/key.
At first, I just set `TMPFILE=no`when runnign ./configure, but that is not a very good solution, because a misconfiguration by users can break the boot. I removed the code and the configuration key altogether prompted by the upstream changes that moved the relevant script to a different repository.
After some changes it works fine.

#### 2.2 systemctl

The code in `local-sysctl` service is simple and effective, but it does match the relevant runit core-service in voidlinux. My option was to reuse the void-runit code in the service. It works fine, I may tweak it in the future.

#### 2.3. module loading behaviour-handling.

Upstream uses a module loading script written from scratch. It works without glaring issues, but since void-runit includes the `modules-load` utility and my goal was to be as close to the distribution as possible, I reused it.
`modules-load` is included in the new *66-void* package. The change was also hastened by the move of the upstream script to a seperate git repository.

#### 2.4 efivarfs mode

Void has efivarfs mounted rw by default. That is a matter of policy and I did the change in the `` service.

### 3 Transitioning from runit and reusing existing service scripts

`void-packages` contains 