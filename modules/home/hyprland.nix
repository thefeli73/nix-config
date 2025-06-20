let
  colors = import ../gruvbox-theme.nix;
in {
  # Hyprland settings
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprpaper"
      ];
      input = {
        kb_layout = "se";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_file = "";

        follow_mouse = 1;

        sensitivity = 0;
      };
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$filemanager" = "nautilus";
      "$menu" = "rofi -show-icons -show drun";

      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 1;
        "col.active_border" = "rgb(${colors.gruvbox-rgb.bright_orange}) rgb(${colors.gruvbox-rgb.red}) 45deg";
        "col.inactive_border" = "rgba(${colors.gruvbox-rgb.bg4}, 0.66)";
        layout = "dwindle";
        allow_tearing = false;
      };
      decoration = {
        rounding = 8;
        rounding_power = 3.5;
        blur = {
          enabled = true;
          xray = true;
          size = 3;
          passes = 4;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };

      # Window rules
      windowrulev2 = [
        # Nice transparency for some apps
        "opacity 0.9,class:^(cursor)$"
        "opacity 0.9,class:^(firefox)$"
        "opacity 0.9,class:^(GitKraken)$"
        "opacity 0.9,class:^(obsidian)$"

        # Keep Rofi focused
        "stayfocused, class:^(Rofi)$"
      ];

      # Bindings
      bind =
        [
          "$mod, RETURN, exec, $terminal"
          "$mod, C, killactive"
          "$mod, E, exec, $filemanager"
          "$mod, SPACE, exec, $menu"
          ", Print, exec, grimblast copy area"
          "$mod, V, togglefloating"
          "$mod, J, togglesplit, " # dwindle
          "$mod, L, exec, hyprlock"

          # Move focus with mainMod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
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
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
