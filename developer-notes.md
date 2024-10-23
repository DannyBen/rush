# Developer Notes

## Prerequisites

- [bashly](https://github.com/DannyBen/bashly)
- [direnv](https://direnv.net/) (optional)
- [opcode](https://github.com/DannyBen/opcode)  (optional)

## Setup

For easy development, configure the folder where you cloned the `rush`
reposotory to use the included sample repo.

If you are using direnv, create this file:

```bash
# .envrc
export RUSH_CONFIG=$PWD/rush-dev.ini
```

Otherwise, export the variable manually.

Then, run:

```
$ rush add sample $PWD/sample-repo
$ rush default sample
```

