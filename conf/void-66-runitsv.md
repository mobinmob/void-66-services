## Runit services with 66

Void linux has a lot of runit service scripts in the void-packages project. An easy way to find then is check the templates for the use of the `vsv` function which is used to install them in the `$DESTDIR` during package creation. These services are currently translated to the 66 frontend format. There is a need that a user will be able to use runit services even if their system is booted with 66 for two reasons:

1. a service that a user needs may not be translated yet and
2. even if a service exists, it is **very** helpful to be able to compare/observe how the service performs in the two systems without rebooting.

### Solution the first 😉 : run a runit supervision tree alongside the s6 one.

This is the first approach that was tried in order to have some services running beyond what is available in `boot@`.

The logic is simple: runit can function as a supervisor on top of an init system, so why not run it on top of s6?

@teldra implemented the first `runit` service frontend. It reused (as in called directly) the code from the runit `2` script and was functional. It was improved but the underlying principles did not change. If a user needs a runit service they enable it with a symlink, as they would without 66 and manage it with `sv`.

If a user chooses to follow the guide, the runit service is enabled in the `runit` tree that starts after the `default` tree. They can use it... ootb.

### runit-wrapsv@ : the new kid on the block

The first solution works, is well tested and understood. It was - still is - invaluable for the development and testing of frontends. So, why ever create another one?

The only real issue with the first approach is that you cannot have a complete view of your system state with a single set of tools - the 66 **or** the runit.

The same property of the first approach that makes it really valuable for development/testing makes it limited for the end user. 

The logic of `runit-wrapsv@` is also simple:
Instead of running a separate runit tree, make a wrapper instanciated service that will call directly the run script of whatever service follows the @.

So, if you want to run runit service for **x** on top of 66, you enable and start it it with:

`66-enable -t runit -S runit-wrapsv@x`

The new "wrapped" service will appear in `66-intree`, and will have meaningful output in 66-inservice. 

Is it perfect? No, a native 66 frontend will be the preferred solution. But it works and with it all one needs for an overview and management of system services are the 66 utilities.

Maybe reusing service definitions from other init systems/services can be achieved in a similar way. We 'll see...

### Known limitations

1. Both solution do not deal with sv-check. In the first case sv check works, but most services that use it already have 66 native frontends. In the second solution it does not work in any meaningful way.
2. `runit-wrapsv@` cannot be used to observe and test frontends in the same way a seperate runit tree can.
