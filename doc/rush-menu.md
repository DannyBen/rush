% rush-menu(1) | Select a package from an interactive menu.
% 
% July 2026

NAME
==================================================

**rush menu** - Select a package from an interactive menu.

SYNOPSIS
==================================================

**rush menu** [REPO_OR_PACKAGE] [OPTIONS]

DESCRIPTION
==================================================

Select a package from an interactive menu.


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

--install, -i
--------------------------------------------------

Install the selected package instead of showing its info.


DEPENDENCIES
==================================================

fzf
--------------------------------------------------


EXAMPLES
==================================================

~~~
rush menu

rush menu --install

rush menu personal

~~~

SEE ALSO
==================================================

**rush**(1)


