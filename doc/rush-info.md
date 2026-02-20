% rush-info(1) | Show information about a package.
% 
% February 2026

NAME
==================================================

**rush info** - Show information about a package.

SYNOPSIS
==================================================

**rush info** PACKAGE

DESCRIPTION
==================================================

Show information about a package.

This command shows the info file from the package directory.

- Alias: **i**

ARGUMENTS
==================================================

PACKAGE
--------------------------------------------------

Package name.

This can either be the package name without the repository name (in this case, the default repository will be used) or in the form of **repo:package**.

- *Required*

EXAMPLES
==================================================

~~~
rush info ruby

rush info centos:ruby

~~~

SEE ALSO
==================================================

**rush**(1)


