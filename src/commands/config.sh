if [[ "${args[--edit]}" ]]; then
  editor="${EDITOR:-vi}"
  "$editor" "$CONFIG_FILE"
else
  cyan "# $CONFIG_FILE"
  config_show
fi
