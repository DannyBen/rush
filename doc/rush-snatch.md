% rush-snatch(1) | Install a package from a remote repo.
% 
% February 2025

NAME
==================================================

**rush snatch** - Install a package from a remote repo.

SYNOPSIS
==================================================

**rush snatch** GITHUB_USER PACKAGE [OPTIONS]

DESCRIPTION
==================================================

Install a package from a remote repo.

This command is a shortcut to running clone followed by get.

It will clone the repository to a temporary directory and run the main package script.


ARGUMENTS
==================================================

GITHUB_USER
--------------------------------------------------

Github user.

This user is expected to have a repository named **rush-repo**.

If you need to use a different name, use the **user/repo** syntax.

- *Required*

PACKAGE
--------------------------------------------------

Package name.

- *Required*

OPTIONS
==================================================

--force, -f
--------------------------------------------------

Force installation.

This may mean different things in different packages.


--verbose, -v
--------------------------------------------------

Show additional details if possible.


--undo, -u
--------------------------------------------------

Run the undo script instead of the main script.


EXAMPLES
==================================================

~~~
rush snatch james python

rush snatch james python --undo

rush snatch james/other-rush-repo python

~~~

SEE ALSO
==================================================

**rush**(1)


