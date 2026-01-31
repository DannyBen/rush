## Collect variables
repo_id=${args[github_user]}
package=${args[package]}
undo=${args[--undo]}
tmpdir="$(mktemp -d -t rush-snatch.XXXXXX)"
path="$tmpdir/snatched"

[[ -n "${args['--force']}" ]] && export FORCE=1
[[ -n "${args['--verbose']}" ]] && export VERBOSE=1

cleanup() {
  rush remove snatched --purge
  rm -r "$tmpdir"
}

say "snatch" "$repo_id $package"

trap cleanup EXIT ERR INT TERM

rush clone "$repo_id" "$path" --name snatched
if [[ $undo ]]; then
  rush undo "snatched:$package"
else
  rush get "snatched:$package"
fi
