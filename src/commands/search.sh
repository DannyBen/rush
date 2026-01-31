text=${args[text]}

for k in $(config_keys); do
  search_repo "$k" "$text"
done
