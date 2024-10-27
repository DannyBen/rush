% rush-push(1) | Git push one or all repositories.
% 
% October 2024

NAME
==================================================

**rush push** - Git push one or all repositories.

SYNOPSIS
==================================================

**rush push** [REPO] [OPTIONS]

DESCRIPTION
==================================================

Git push one or all repositories.

- Alias: **upload**

ARGUMENTS
==================================================

REPO
--------------------------------------------------

Repository name.

- Default Value: **default**

OPTIONS
==================================================

--all, -a
--------------------------------------------------

Push all repositories.


--message, -m TEXT
--------------------------------------------------

Commit message.

- Default Value: **automatic commit**

--chmod, -x
--------------------------------------------------

Apply the executable bit to all main and undo scripts in the git repository index.


DEPENDENCIES
==================================================

git
--------------------------------------------------


SEE ALSO
==================================================

**rush**(1)


