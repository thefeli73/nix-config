set -euo pipefail

if [[ $# -ne 1 ]]; then
  printf 'Usage: %s low|auto\n' "$0" >&2
  exit 2
fi

profile="$1"
if [[ "$profile" != "low" && "$profile" != "auto" ]]; then
  printf 'Usage: %s low|auto\n' "$0" >&2
  exit 2
fi

for device in /sys/class/drm/card*/device; do
  [[ -e "$device/vendor" ]] || continue
  [[ -e "$device/power_dpm_force_performance_level" ]] || continue

  vendor="$(<"$device/vendor")"
  if [[ "$vendor" != "0x1002" ]]; then
    continue
  fi

  printf '%s\n' "$profile" >"$device/power_dpm_force_performance_level"
  exit 0
done

printf 'No AMD DRM device with power_dpm_force_performance_level found\n' >&2
exit 1
