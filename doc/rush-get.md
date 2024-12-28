% rush-get(1) | Install a package.
% 
% December 2024

NAME
==================================================

**rush get** - Install a package.

SYNOPSIS
==================================================

rush [get] PACKAGE [OPTIONS]

DESCRIPTION
==================================================

Install a package.

This command runs the main script in the package directory.

This is the default command, which means that running **rush package** is the same as running **rush get package**.

- *Default Command*
- Alias: **g**

ARGUMENTS
==================================================

PACKAGE
--------------------------------------------------

Package name.

This can either be the package name without the repository name (in this case, the default repository will be used) or in the form of **repo:package**.

- *Required*

OPTIONS
==================================================

--clone, -c
--------------------------------------------------

Clone the repository if it is not found locally.

This flag will look for a GitHub user with the same name as the repository, and attempt to clone their rush-repo repository.


--force, -f
--------------------------------------------------

Force installation.

This may mean different things in different packages.


--verbose, -v
--------------------------------------------------

Show additional details if possible.


EXAMPLES
==================================================

~~~
rush ruby

rush get ruby --force

rush get centos:ruby

~~~

SEE ALSO
==================================================

**rush**(1)


