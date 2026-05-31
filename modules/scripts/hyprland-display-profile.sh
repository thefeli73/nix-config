set -euo pipefail

usage() {
  printf 'Usage: %s apply powersave|balanced|performance\n' "$0" >&2
  printf '       %s sdr-temporary -- command [args...]\n' "$0" >&2
}

apply_profile() {
  profile="$1"

  case "$profile" in
    powersave)
      hyprctl --batch 'keyword misc:vrr 0; keyword monitor DP-1, 2560x1440@120.00, 0x0, 1, vrr, 0, cm, srgb; keyword monitor DP-3, 2560x1440@120.00, auto-right, 1, vrr, 0, cm, srgb'
      ;;
    balanced)
      hyprctl --batch 'keyword misc:vrr 2; keyword monitor DP-1, 2560x1440@200.00, 0x0, 1, vrr, 2, cm, srgb; keyword monitor DP-3, 2560x1440@143.97, auto-right, 1, vrr, 2, cm, srgb'
      ;;
    performance)
      hyprctl --batch 'keyword misc:vrr 2; keyword monitor DP-1, 2560x1440@200.00, 0x0, 1, vrr, 2, bitdepth, 10, cm, hdr, sdrbrightness, 1.2; keyword monitor DP-3, 2560x1440@143.97, auto-right, 1, vrr, 2, bitdepth, 10, cm, hdr, sdrbrightness, 1.2'
      ;;
    *)
      printf 'Unknown Hyprland display profile: %s\n' "$profile" >&2
      exit 2
      ;;
  esac
}

sdr_temporary() {
  if [[ "${1:-}" != "--" ]]; then
    usage
    exit 2
  fi
  shift

  if [[ $# -eq 0 ]]; then
    usage
    exit 2
  fi

  monitors_json="$(hyprctl monitors -j)"
  mapfile -t hdr_monitors < <(printf '%s' "$monitors_json" | jq -r '.[] | select(.colorManagementPreset == "hdr") | .name')

  restore_batch=""
  sdr_batch=""

  for name in "${hdr_monitors[@]}"; do
    restore_line=$(printf '%s' "$monitors_json" | jq -r --arg name "$name" '.[] | select(.name==$name) |
      "\(.name), \(.width)x\(.height)@\(.refreshRate), \(.x)x\(.y), \(.scale), vrr, \(.vrr | if . then 1 else 0 end), bitdepth, \(
        if (.currentFormat | test("2101010")) then 10 else 8 end
      ), cm, hdr, sdrbrightness, \(.sdrBrightness)"')

    sdr_line=$(printf '%s' "$monitors_json" | jq -r --arg name "$name" '.[] | select(.name==$name) | "\(.name), \(.width)x\(.height)@\(.refreshRate), \(.x)x\(.y), \(.scale), vrr, \(.vrr | if . then 1 else 0 end)"')

    restore_batch+="keyword monitor ${restore_line}; "
    sdr_batch+="keyword monitor ${sdr_line}; "
  done

  restore() {
    if [[ -n "$restore_batch" ]]; then
      hyprctl --batch "$restore_batch" >/dev/null
    fi
  }

  trap restore EXIT INT TERM

  if [[ -n "$sdr_batch" ]]; then
    hyprctl --batch "$sdr_batch" >/dev/null
    sleep 0.2
  fi

  "$@"
}

case "${1:-}" in
  apply)
    if [[ $# -ne 2 ]]; then
      usage
      exit 2
    fi
    shift
    apply_profile "$1"
    ;;
  sdr-temporary)
    shift
    sdr_temporary "$@"
    ;;
  *)
    usage
    exit 2
    ;;
esac
