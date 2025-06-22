let
  colors = import ../gruvbox-theme.nix;
in {
  # Hyprland settings
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprpaper"
        "hypridle"
        "hyprsunset"
        "hyprctl setcursor capitaine-cursors-white 32" # Set mouse cursor
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
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

        repeat_delay = 200;
        repeat_rate = 30;
      };
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$filemanager" = "nautilus";
      "$menu" = "rofi -show-icons -show drun";

      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 1;
        "col.active_border" = "rgba(${colors.gruvbox-rgb.bright_orange},1.0) rgba(${colors.gruvbox-rgb.red},1.0) 45deg";
        "col.inactive_border" = "rgba(${colors.gruvbox-rgb.bg4},0.66)";
        layout = "dwindle";
        allow_tearing = false;
      };
      decoration = {
        rounding = 10;
        rounding_power = 4;
        blur = {
          enabled = true;
          xray = true;
          size = 4;
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
        # Nice transparency for some apps (unless in fullscreen)
        "opacity 0.9,fullscreen:0,class:^(cursor)$"
        "opacity 0.9,fullscreen:0,class:^(firefox)$"
        "opacity 0.9,fullscreen:0,class:^(GitKraken)$"
        "opacity 0.9,fullscreen:0,class:^(obsidian)$"

        # Keep Rofi focused
        "stayfocused, class:^(Rofi)$"
      ];

      # Bindings
      bind =
        [
          "$mod, RETURN, exec, $terminal" # Open terminal
          "$mod, C, killactive" # Kill active window
          "$mod, E, exec, $filemanager" # Open file manager
          "$mod, SPACE, exec, $menu" # Show menu (rofi)
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy" # Show Clipboard history
          ", PRINT, exec, hyprshot -m region" # Screenshot region
          "$mod, PRINT, exec, hyprshot -m window" # Screenshot window
          "$mod, F, togglefloating" # Make active window floating
          "$mod, J, togglesplit, " # dwindle
          "$mod, L, exec, hyprlock" # Lock screen

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

      # l -> do stuff even when locked
      # e -> repeats when key is held
      bindle = [
        ", XF86AudioRaiseVolume, exec, vol --up"
        ", XF86AudioLowerVolume, exec, vol --down"
        ", XF86MonBrightnessUp, exec, bri --up"
        ", XF86MonBrightnessDown, exec, bri --down"
        ", XF86Search, exec, launchpad"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause" # the stupid key is called play , but it toggles
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
