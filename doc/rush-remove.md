% rush-remove(1) | Unregister a local repository.
% 
% February 2025

NAME
==================================================

**rush remove** - Unregister a local repository.

SYNOPSIS
==================================================

**rush remove** REPO [OPTIONS]

DESCRIPTION
==================================================

Unregister a local repository.

This command removes the specified path to the configuration file.

- Alias: **r**

ARGUMENTS
==================================================

REPO
--------------------------------------------------

Repository name.

- *Required*

OPTIONS
==================================================

--purge, -p
--------------------------------------------------

Also remove the local repository's directory.


EXAMPLES
==================================================

~~~
rush remove bobby

rush remove bobby --purge

~~~

SEE ALSO
==================================================

**rush**(1)


