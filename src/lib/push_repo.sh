push_repo() {
  local repo_path="$1"
  local repo="$2"

  if [[ -d "$repo_path/.git" ]]; then
    say "push" "$repo"
    (
      set -e
      cd "$repo_path"
      
      say "push" "$repo: adding files"
      git add . --all
      
      local added_exec_files
      added_exec_files="$(git diff --cached --name-only --diff-filter=A -- \
        ':(glob)**/main' \
        ':(glob)**/undo' \
        'main' \
        'undo')"
      if [[ -n "$added_exec_files" ]]; then
        say "push" "$repo: applying chmod +x to new main/undo files"
        while IFS= read -r exec_file; do
          git update-index --chmod=+x "$exec_file"
        done <<<"$added_exec_files"
      fi
      say "push" "$repo: committing"
      git commit -am "$message"
      
      say "push" "$repo: pushing"
      git push
    )
  else
    say "push" "$repo: skipping (not a git repo)"
  fi
}
