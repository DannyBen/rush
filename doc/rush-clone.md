% rush-clone(1) | Clone a GitHub package repository.
% 
% February 2026

NAME
==================================================

**rush clone** - Clone a GitHub package repository.

SYNOPSIS
==================================================

**rush clone** GITHUB_USER [PATH] [OPTIONS]

DESCRIPTION
==================================================

Clone a GitHub package repository.

This command clones the repository and registers it in the configuration file.


ARGUMENTS
==================================================

GITHUB_USER
--------------------------------------------------

Github user.

This user is expected to have a repository named **rush-repo**.

If you need to use a different name, use the **user/repo** syntax.

- *Required*

PATH
--------------------------------------------------

Local path to clone the repository into.

Default: ~/rush-repos/\<github_user\>/\<github_repo\>


OPTIONS
==================================================

--ssh, -s
--------------------------------------------------

Clone using SSH instead of HTTPS.


--default, -d
--------------------------------------------------

Set this as the default repository (same as **--name default**).


--name, -n NAME
--------------------------------------------------

Name to use in the config file.

Default: GitHub user


--shallow, -w
--------------------------------------------------

Perform a shallow clone, instead of the default full clone.


--ignore, -i
--------------------------------------------------

Ignore (do not clone) if a repository with this name exists.


DEPENDENCIES
==================================================

git
--------------------------------------------------


EXAMPLES
==================================================

~~~
rush clone bobby

rush clone bobby --default

rush clone bobby/bobs-repo ./repos/bobby --ssh

rush clone bobby --name sample --ignore

~~~

SEE ALSO
==================================================

**rush**(1)


