set -euo pipefail

home=${HOME:?}
selection=${1-}
tilde='~'

to_path() {
  if [[ "$1" == "$tilde" ]]; then
    printf '%s\n' "$home"
  elif [[ "$1" == "$tilde/"* ]]; then
    printf '%s/%s\n' "$home" "${1#"$tilde"/}"
  elif [[ "$1" == /* ]]; then
    printf '%s\n' "$1"
  else
    printf '%s/%s\n' "$home" "$1"
  fi
}

display_path() {
  if [[ "$1" == "$home" ]]; then
    printf '%s\n' "$tilde"
  else
    printf '%s/%s\n' "$tilde" "${1#"$home"/}"
  fi
}

list_entries() {
  display_path "$home"

  fd --absolute-path --color=never \
    --max-results 5000 \
    --exclude .git \
    --exclude .cache \
    --exclude .direnv \
    --exclude .next \
    --exclude build \
    --exclude dist \
    --exclude node_modules \
    --exclude result \
    --exclude target \
    --exclude .local/share/Trash \
    . "$home" \
    | while IFS= read -r path; do
      display_path "$path"
    done
}

open_selection() {
  local path parent

  path=$(to_path "$1")

  if [[ -d "$path" ]]; then
    (nautilus "$path" || xdg-open "$path") >/dev/null 2>&1 &
    return
  fi

  if [[ -f "$path" ]]; then
    parent=${path%/*}
    (nautilus --select "$path" || xdg-open "$parent") >/dev/null 2>&1 &
  fi
}

if [[ -z "$selection" ]]; then
  list_entries
else
  open_selection "$selection"
fi
