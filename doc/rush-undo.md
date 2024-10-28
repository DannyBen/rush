% rush-undo(1) | Uninstall a package.
% 
% October 2024

NAME
==================================================

**rush undo** - Uninstall a package.

SYNOPSIS
==================================================

**rush undo** PACKAGE [OPTIONS]

DESCRIPTION
==================================================

Uninstall a package.

This command runs the undo script in the package directory.

- Alias: **u**

ARGUMENTS
==================================================

PACKAGE
--------------------------------------------------

Package name.

This can either be the package name without the repository name (in this case, the default repository will be used) or in the form of **repo:package**.

- *Required*

OPTIONS
==================================================

--verbose, -v
--------------------------------------------------

Show additional details if possible.


EXAMPLES
==================================================

~~~
rush undo ruby

rush undo centos:ruby

~~~

SEE ALSO
==================================================

**rush**(1)


