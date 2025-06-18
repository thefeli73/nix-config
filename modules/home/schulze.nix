{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "25.05"; # Dont change

  # Hyprland settings
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "se";
    };
    "$mod" = "SUPER";
    "$terminal" = "ghostty";
    "$filemanager" = "nautilus";
    "$menu" = "rofi -show drun";

    general = {
      gaps_in = 4;
      gaps_out = 4;
      border_size = 1;
      "col.active_border" = "rgba(ebdbb2ee) rgba(fe8019ee) 45deg";
      "col.inactive_border" = "rgba(7c6f64aa)";
    };
    decoration = {
      rounding = "8";
      rounding_power = "3";
      blur = {
        enabled = "true";
        xray = "true";
        size = "3";
        passes = "4";
      };
    };

    # Bindings
    bind =
      [
        "$mod, RETURN, exec, $terminal"
        "$mod, C, killactive"
        "$mod, E, exec, $filemanager"
        "$mod, SPACE, exec, $menu"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
  wayland.windowManager.hyprland.extraConfig = ''
    monitor = DP-3, 2560x1440@143.97301, 1920x0, auto;
    monitor = HDMI-A-1, 1920x1080@60, 0x0, auto;
  '';
}
