{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "25.05"; # Dont change

  # Hyprland settings
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "ghostty";
    "$filemanager" = "nautilus";
    "$menu" = "rofi -show drun";

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
    decoration = {
      rounding = "15";
      rounding_power = "4";
      blur = {
        enabled = "true";
        xray = "true";
        size = "3";
        passes = "4";
      };
    };
  };
}
