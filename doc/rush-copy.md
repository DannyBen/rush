% rush-copy(1) | Copy a package between local repositories.
% 
% December 2024

NAME
==================================================

**rush copy** - Copy a package between local repositories.

SYNOPSIS
==================================================

**rush copy** SOURCE_PACKAGE [TARGET_PACKAGE] [OPTIONS]

DESCRIPTION
==================================================

Copy a package between local repositories.


ARGUMENTS
==================================================

SOURCE_PACKAGE
--------------------------------------------------

Source package name.

This can either be the package name without the repository name (in this case, the default repository will be used) or in the form of **repo:package**.

- *Required*

TARGET_PACKAGE
--------------------------------------------------

Target package name.

This can either be the package name without the repository name (in this case, the default repository will be used) or in the form of **repo:package**.

If left empty, the package will be copied with the same name to the default repository.


OPTIONS
==================================================

--force, -f
--------------------------------------------------

Copy the package even if it already exists in the target repository.


EXAMPLES
==================================================

~~~
rush copy james:python

rush copy james:python python3

rush copy james:python bobby:python3 --force

~~~

SEE ALSO
==================================================

**rush**(1)


