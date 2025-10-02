# Rush - Personal Package Manager

```
_______                       ______  
____  /  ___________  ___________  /_ 
___  /   __  ___/  / / /_  ___/_  __ \
__  /    _  /   / /_/ /_(__  )_  / / /
_  /     /_/    \__,_/ /____/ /_/ /_/ 
/_/      Personal Package Manager     
```

[![Build Status](https://github.com/DannyBen/rush/workflows/Test/badge.svg)](https://github.com/DannyBen/rush/actions?query=workflow%3ATest)

---

Rush is a bash script that executes other scripts (bash or other languages)
from compatible GitHub repositories or local folders. It provides a simple
command line interface for downloading, updating and running these scripts.

See [this minimal sample rush repo][sample], or a real life example
repo at [DannyBen/rush-repo][dannyben-repo].

Rush was designed to easily allow bootstrapping of new linux machines with 
your desired configuration and installed packages and to "normalize" the way
you install things.

Rush was developed using the [Bashly Command Line Framework][bashly].


## Prerequisites

- Bash 4.0 or higher (`brew install bash` on mac).
- curl 
- git


## Installation

### Installing using the setup script

This setup script will download the rush executable to `/usr/local/bin/` and
install an autocomplete script in the bash completions directory.

```shell
$ curl -Ls get.dannyb.co/rush/setup | bash
```

Feel free to inspect the [setup script](setup) before running.


### Installing manually

Download the [rush](rush) script to `/usr/local/bin/` or anywhere in your
`PATH`, and make it executable.

If you wish to have all package name auto-completed for all `rush` commands, 
add this line to your startup script (for example: `~/.bashrc`):

```bash
complete -W '$(rush list -s)' rush
```


## Quick Start

After installing, you can follow these steps to quickly see how it works:

```shell
# Clone a sample package repository
$ rush clone dannyben/rush-repo-template --name sample

# View the config file and verify it was added
$ rush config

# View list of packages
$ rush list

# Install (execute) a sample package
# (All packages in the sample repository only print some messages)
$ rush get sample:hello 

# Optionally, make this repository the default
$ rush default sample

# And now you can omit the repository name when getting a package
$ rush get hello

# Since `get` is the default command, the above command is the same as
$ rush hello
```

In case you prefer testing Rush in a clean, isolated docker environment, you
can use [this docker image][docker-image], which has Rush copied to its path:

    $ docker run --rm -it --entrypoint bash dannyben/rush
    > rush --help


## Usage

```
$ rush --help

rush - Personal package manager

Usage:
  rush COMMAND
  rush [COMMAND] --help | -h
  rush --version | -v

Repository Commands:
  add           Register a local repository
  remove        Unregister a local repository

Git Commands:
  clone         Clone a GitHub package repository
  pull          Git pull one or all repositories
  push          Git push one or all repositories

Config Commands:
  config        Show or edit the configuration file
  default       Set a default repository

Package Commands:
  get           Install a package (default)
  undo          Uninstall a package
  snatch        Install a package from a remote repo
  copy          Copy a package between local repositories
  info          Show information about a package
  list          Show packages in one or all repositories
  search        Search in package names and info files
  edit          Edit package files
  show          Show package files

Internal Commands:
  completions   Generate bash completions

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  RUSH_CONFIG
    Location of the rush config file

    Default: ~/rush.ini

  RUSH_ROOT
    Location of the default base directory for cloning repositories.

    Default: ~/rush-repos
```


## Building your own Rush repository

Create your own repository, either manually or by using
[this Github template][sample]. In any case, it is recommended you name your 
repository **rush-repo**.

To create a repository manually, follow these steps:

1. Create a new repository on GitHub, named `rush-repo`.
2. Each folder you create in this repository is considered a package.
3. Each package needs to have these files:
   - An executable script named `main` - this will be executed when running
     `rush get yourpackage`.
   - A plain text file called `info` - this will be shown when running
     `rush info yourpackage`.
   - An executable script named `undo` (optional) - this will be executed 
     when running `rush undo yourpackage`.
4. In the `main` and `undo` scripts, you have the following environment
   variables available to you:
   - `$REPO` - name of the rush repo
   - `$REPO_PATH` - path of the rush repo
   - `$USER_CWD` - the directory from which rush was executed
   - `$VERBOSE` - if the user passed `--verbose`
   - `$FORCE` - if the user passed `--force`
5. Note that the `main` and `undo` scripts are executed in the same folder they
   live in, so you can copy files from the package's directory to wherever
   they need to be.
6. If you need to read/write files in the user's current directory, use the
   `$USER_CWD` environment variable.
7. The `main` and `undo` scripts can be written in any language, as long as
   they have a shebang line.



## Using with GitHub Actions

Rush can be very useful for running remote shell scripts as part of your
GitHub Actions workflow. This sample configuration shows how to install rush
and connect to your rush repository from a GitHub Actions workflow.

```yaml
# .github/workflows/main.yml
name: Test
on: [push]

jobs:
  main:
    name: Rush demo
    runs-on: ubuntu-latest

    steps:
    - name: Install rush
      run: curl -Ls http://get.dannyb.co/rush/setup | bash

    # Replace with your own repository
    - name: Connect to rush repository
      run: rush clone dannyben/rush-repo-template --default --shallow

    - name: Run a sample script from the repo
      run: rush get hello
```

## Uninstalling

```shell
$ curl -Ls get.dannyb.co/rush/uninstall | bash
```

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

<table>
  <tr><td align="center" colspan="4"><strong>This repository is part of the Bash Productivity Suite</strong></td></tr>
  <tr>
    <td><a href="https://github.com/dannyben/alf"><img src="https://github.dannyben.com/assets/img/alf.png"></a></td>
    <td><a href="https://github.com/dannyben/opcode"><img src="https://github.dannyben.com/assets/img/opcode.png"></a></td>
    <td><a href="https://github.com/dannyben/fuzzycd"><img src="https://github.dannyben.com/assets/img/fuzzycd.png"></a></td>
    <td><a href="https://github.com/dannyben/rush"><img src="https://github.dannyben.com/assets/img/rush.png"></a></td>
  </tr>
</table>

---

[sample]: https://github.com/DannyBen/rush-repo-template
[dannyben-repo]: https://github.com/dannyben/rush-repo
[bashly]: https://bashly.dannyb.co/
[docker-image]: https://github.com/dannyben/docker-rush
[issues]: https://github.com/DannyBen/rush/issues
