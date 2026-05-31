{
  lib,
  pkgs,
  ...
}: let
  scripts = import ../../../modules/scripts {inherit pkgs;};
in {
  # Home Manager Hyprland monitors
  wayland.windowManager.hyprland.settings = {
    exec-once = lib.mkAfter [
      "${scripts.desktop-power-profile}/bin/desktop-power-profile set powersave"
    ];

    monitor = [
      "DP-3, 2560x1440@120.00, auto-right, 1, vrr, 0, cm, srgb"
      "DP-1, 2560x1440@120.00, 0x0, 1, vrr, 0, cm, srgb"
    ];
  };
}
