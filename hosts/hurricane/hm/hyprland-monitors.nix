{
  config,
  pkgs,
  ...
}: let
  internalDisplay = "eDP-1";
  internalMonitor = "${internalDisplay}, 1920x1200@60.00, 6880x240, 1";
  hyprlandService = "wayland-wm@hyprland.desktop.service";

  lidPolicy = pkgs.writeShellScript "hurricane-lid-policy" ''
    set -u

    timeout_cmd() {
      ${pkgs.coreutils}/bin/timeout --foreground --kill-after=1s 2s "$@"
    }

    read_monitors() {
      local monitors

      monitors="$(timeout_cmd ${pkgs.hyprland}/bin/hyprctl monitors -j)" || return 1
      ${pkgs.jq}/bin/jq -e 'type == "array"' <<<"$monitors" >/dev/null || return 1
      printf '%s\n' "$monitors"
    }

    session_active() {
      local session

      session="$(timeout_cmd ${pkgs.systemd}/bin/loginctl show-seat seat0 --property=ActiveSession --value)" || return 1
      [[ -n "$session" ]] || return 1
      [[ "$(timeout_cmd ${pkgs.systemd}/bin/loginctl show-session "$session" --property=Name --value)" == "${config.home.username}" ]] || return 1
      [[ "$(timeout_cmd ${pkgs.systemd}/bin/loginctl show-session "$session" --property=Type --value)" == "wayland" ]] || return 1
      [[ "$(timeout_cmd ${pkgs.systemd}/bin/loginctl show-session "$session" --property=Active --value)" == "yes" ]] || return 1
      [[ "$(timeout_cmd ${pkgs.systemd}/bin/loginctl show-session "$session" --property=Remote --value)" == "no" ]]
    }

    lid_state() {
      case "$(timeout_cmd ${pkgs.systemd}/bin/busctl get-property org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager LidClosed)" in
        "b true") printf 'closed\n' ;;
        "b false") printf 'open\n' ;;
        *) return 1 ;;
      esac
    }

    internal_present() {
      ${pkgs.jq}/bin/jq -e 'any(.[]; .name == "${internalDisplay}")' <<<"$1" >/dev/null
    }

    internal_powered() {
      ${pkgs.jq}/bin/jq -e 'any(.[]; .name == "${internalDisplay}" and .dpmsStatus == true)' <<<"$1" >/dev/null
    }

    external_present() {
      ${pkgs.jq}/bin/jq -e 'any(.[]; .name == "DP-3" or .name == "HDMI-A-1")' <<<"$1" >/dev/null
    }

    restore_internal() {
      local monitors

      for _ in {1..6}; do
        if monitors="$(read_monitors)"; then
          if internal_powered "$monitors"; then
            return 0
          elif internal_present "$monitors"; then
            timeout_cmd ${pkgs.hyprland}/bin/hyprctl dispatch dpms on '${internalDisplay}' || true
          else
            timeout_cmd ${pkgs.hyprland}/bin/hyprctl keyword monitor '${internalMonitor}' || true
          fi
        fi
        ${pkgs.coreutils}/bin/sleep 0.25
      done

      monitors="$(read_monitors)" || return 1
      internal_powered "$monitors"
    }

    restore_internal_quick() {
      local monitors

      monitors="$(read_monitors)" || return 1
      if internal_powered "$monitors"; then
        return 0
      elif internal_present "$monitors"; then
        timeout_cmd ${pkgs.hyprland}/bin/hyprctl dispatch dpms on '${internalDisplay}'
      else
        timeout_cmd ${pkgs.hyprland}/bin/hyprctl keyword monitor '${internalMonitor}'
      fi
    }

    disable_internal() {
      local monitors

      for _ in {1..8}; do
        if monitors="$(read_monitors)"; then
          if ! internal_present "$monitors"; then
            return 0
          fi
          timeout_cmd ${pkgs.hyprland}/bin/hyprctl keyword monitor '${internalDisplay}, disable' || true
        fi
        ${pkgs.coreutils}/bin/sleep 0.25
      done

      monitors="$(read_monitors)" || return 1
      ! internal_present "$monitors"
    }

    request_suspend() {
      local mode="$1"
      local lid
      local monitors

      session_active || return 1
      lid="$(lid_state)" || return 1
      [[ "$lid" == "closed" ]] || return 0
      timeout_cmd ${pkgs.systemd}/bin/systemctl --no-block suspend || return 1
      ${pkgs.coreutils}/bin/sleep 5

      lid="$(lid_state)" || return 1
      [[ "$lid" == "open" ]] && return 0
      [[ "$mode" == "force" ]] && return 1

      monitors="$(read_monitors)" || return 1
      external_present "$monitors"
    }

    reconcile_closed() {
      local lid
      local monitors

      monitors="$(read_monitors)" || return 1
      if external_present "$monitors"; then
        session_active || return 1
        lid="$(lid_state)" || return 1
        [[ "$lid" == "closed" ]] || return 0
        if disable_internal; then
          return 0
        fi
        restore_internal || true
        request_suspend force
        return
      fi

      restore_internal || return 1
      ${pkgs.coreutils}/bin/sleep 0.5
      session_active || return 1
      lid="$(lid_state)" || return 1
      [[ "$lid" == "closed" ]] || return 0
      monitors="$(read_monitors)" || return 1

      if external_present "$monitors"; then
        session_active || return 1
        lid="$(lid_state)" || return 1
        [[ "$lid" == "closed" ]] || return 0
        disable_internal || {
          restore_internal || true
          request_suspend force
        }
      else
        request_suspend normal
      fi
    }

    run_inner() {
      local lid

      trap 'restore_internal_quick || true' EXIT
      while session_active; do
        lid="$(lid_state)" || return 1
        if [[ "$lid" == "open" ]]; then
          restore_internal || return 1
        else
          reconcile_closed || return 1
        fi
        ${pkgs.coreutils}/bin/sleep 1
      done
      return 1
    }

    run_outer() {
      local lid

      while true; do
        if session_active && read_monitors >/dev/null; then
          ${pkgs.systemd}/bin/systemd-inhibit \
            --what=handle-lid-switch \
            --who=hyprland-lid-policy \
            --why='Hyprland session manages Hurricane lid policy' \
            --mode=block \
            "$0" inner || true

          while true; do
            lid="$(lid_state)" || {
              ${pkgs.coreutils}/bin/sleep 1
              continue
            }
            [[ "$lid" == "open" ]] && break
            ${pkgs.coreutils}/bin/sleep 1
          done
        fi
        ${pkgs.coreutils}/bin/sleep 5
      done
    }

    case "$1" in
      inner) run_inner ;;
      outer) run_outer ;;
      restore) restore_internal_quick ;;
      *) exit 2 ;;
    esac
  '';
in {
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 3440x1440@99.98, 0x0, 1, cm, auto" # Philips Ultrawide left
    "HDMI-A-1, 3440x1440@99.98, 3440x0, 1, cm, auto" # Philips Ultrawide right
    internalMonitor # internal display
  ];

  systemd.user.services.hyprland-lid-policy = {
    Unit = {
      Description = "Hurricane Hyprland lid policy";
      BindsTo = [hyprlandService];
      After = [hyprlandService];
      PartOf = [hyprlandService];
      StartLimitIntervalSec = 30;
      StartLimitBurst = 5;
    };

    Service = {
      ExecStart = "${lidPolicy} outer";
      ExecStopPost = "-${lidPolicy} restore";
      Restart = "on-failure";
      RestartSec = 5;
      TimeoutStopSec = 12;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
