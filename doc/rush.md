% rush(1) Version 0.7.16 | Personal package manager.
% Danny Ben Shitrit \<https://github.com/dannyben\>
% December 2024

NAME
==================================================

**rush** - Personal package manager.

SYNOPSIS
==================================================

**rush** COMMAND

DESCRIPTION
==================================================

Personal package manager.


REPOSITORY COMMANDS
==================================================

rush add
--------------------------------------------------

Register a local repository.

rush remove
--------------------------------------------------

Unregister a local repository.


GIT COMMANDS
==================================================

rush clone
--------------------------------------------------

Clone a GitHub package repository.

rush pull
--------------------------------------------------

Git pull one or all repositories.

rush push
--------------------------------------------------

Git push one or all repositories.


CONFIG COMMANDS
==================================================

rush config
--------------------------------------------------

Show or edit the configuration file.

rush default
--------------------------------------------------

Set a default repository.


PACKAGE COMMANDS
==================================================

rush get
--------------------------------------------------

Install a package.

rush undo
--------------------------------------------------

Uninstall a package.

rush snatch
--------------------------------------------------

Install a package from a remote repo.

rush copy
--------------------------------------------------

Copy a package between local repositories.

rush info
--------------------------------------------------

Show information about a package.

rush list
--------------------------------------------------

Show packages in one or all repositories.

rush search
--------------------------------------------------

Search in package names and info files.

rush edit
--------------------------------------------------

Edit package files.

rush show
--------------------------------------------------

Show package files.


INTERNAL COMMANDS
==================================================

rush completions
--------------------------------------------------

Generate bash completions.


ENVIRONMENT VARIABLES
==================================================

RUSH_CONFIG
--------------------------------------------------

Location of the rush config file.

Default: ~/rush.ini


RUSH_ROOT
--------------------------------------------------

Location of the default base directory for cloning repositories.

Default: ~/rush-repos


SEE ALSO
==================================================

**rush-add**(1), **rush-remove**(1), **rush-clone**(1), **rush-pull**(1), **rush-push**(1), **rush-config**(1), **rush-default**(1), **rush-get**(1), **rush-undo**(1), **rush-snatch**(1), **rush-copy**(1), **rush-info**(1), **rush-list**(1), **rush-search**(1), **rush-edit**(1), **rush-show**(1), **rush-completions**(1)

# SOURCE CODE

https://github.com/dannyben/rush

# ISSUE TRACKER

https://github.com/dannyben/rush/issues
