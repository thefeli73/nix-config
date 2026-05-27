set -euo pipefail

state_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
state_file="$state_dir/desktop-power-profile"
gpu_helper="/run/current-system/sw/bin/amdgpu-force-profile"
sudo_bin="/run/wrappers/bin/sudo"

valid_profile() {
  case "$1" in
    powersave | balanced | performance) return 0 ;;
    *) return 1 ;;
  esac
}

current_profile() {
  if [[ -r "$state_file" ]]; then
    profile="$(<"$state_file")"
    if valid_profile "$profile"; then
      printf '%s\n' "$profile"
      return 0
    fi
  fi

  printf 'unknown\n'
}

write_profile() {
  mkdir -p "$state_dir"
  printf '%s\n' "$1" >"$state_file"
}

set_gpu_profile() {
  "$sudo_bin" -n "$gpu_helper" "$1"
}

apply_profile() {
  profile="$1"
  if ! valid_profile "$profile"; then
    printf 'Unknown desktop power profile: %s\n' "$profile" >&2
    exit 2
  fi

  case "$profile" in
    powersave)
      powerprofilesctl set power-saver
      set_gpu_profile low
      hyprland-display-profile apply powersave
      ;;
    balanced)
      powerprofilesctl set balanced
      set_gpu_profile auto
      hyprland-display-profile apply balanced
      ;;
    performance)
      powerprofilesctl set performance
      set_gpu_profile auto
      hyprland-display-profile apply performance
      ;;
  esac

  write_profile "$profile"
}

print_status() {
  profile="$(current_profile)"
  case "$profile" in
    powersave)
      printf '{"text":"","tooltip":"Desktop power profile: powersave\\nGPU: low\\nDisplays: SDR 120 Hz","class":"powersave"}\n'
      ;;
    balanced)
      printf '{"text":"","tooltip":"Desktop power profile: balanced\\nGPU: auto\\nDisplays: SDR high refresh","class":"balanced"}\n'
      ;;
    performance)
      printf '{"text":"","tooltip":"Desktop power profile: performance\\nGPU: auto\\nDisplays: HDR high refresh","class":"performance"}\n'
      ;;
    unknown)
      printf '{"text":"?","tooltip":"Desktop power profile: unknown\\nClick to set powersave","class":"unknown"}\n'
      ;;
  esac
}

case "${1:-status}" in
  status)
    [[ $# -le 1 ]] || { printf 'Usage: %s [status|next|set powersave|set balanced|set performance]\n' "$0" >&2; exit 2; }
    print_status
    ;;
  set)
    [[ $# -eq 2 ]] || { printf 'Usage: %s set powersave|balanced|performance\n' "$0" >&2; exit 2; }
    apply_profile "${2:-}"
    print_status
    ;;
  next)
    [[ $# -eq 1 ]] || { printf 'Usage: %s next\n' "$0" >&2; exit 2; }
    case "$(current_profile)" in
      powersave) apply_profile balanced ;;
      balanced) apply_profile performance ;;
      performance | unknown) apply_profile powersave ;;
    esac
    print_status
    ;;
  *)
    printf 'Usage: %s [status|next|set powersave|set balanced|set performance]\n' "$0" >&2
    exit 2
    ;;
esac
