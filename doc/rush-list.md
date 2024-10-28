% rush-list(1) | Show packages in one or all repositories.
% 
% October 2024

NAME
==================================================

**rush list** - Show packages in one or all repositories.

SYNOPSIS
==================================================

**rush list** [REPO_OR_PACKAGE] [OPTIONS]

DESCRIPTION
==================================================

Show packages in one or all repositories.

- Alias: **l, ls**

ARGUMENTS
==================================================

REPO_OR_PACKAGE
--------------------------------------------------

Repository name or package name.

Leave blank to show all packages in all repositories.

Provide a repository name to show only packages in this repository.

Provide a package name (may be in the form of **repo:package**) to show nested packages.


OPTIONS
==================================================

--simple, -s
--------------------------------------------------

Show only package names.


--all, -a
--------------------------------------------------

Show nested packages as well.


EXAMPLES
==================================================

~~~
rush list

rush list personal:apps

rush list personal

rush list apps

rush list apps --simple --all

~~~

SEE ALSO
==================================================

**rush**(1)


