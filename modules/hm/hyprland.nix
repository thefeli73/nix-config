let
  colors = import ../gruvbox-theme.nix;
in {
  # Hyprland settings
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      exec-once = [
        "hyprctl setcursor capitaine-cursors 32" # Set mouse cursor
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "stretchly" # Launch Break reminder
      ];

      misc = {
        disable_hyprland_logo = true; # disables the random Hyprland logo / anime girl background. :(
        disable_splash_rendering = true;
      };

      input = {
        kb_layout = "se";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_file = "";

        follow_mouse = 1;

        sensitivity = 0;
        accel_profile = "flat";

        repeat_delay = 300;
        repeat_rate = 30;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe_forever = true;
        workspace_swipe_direction_lock = false;
        workspace_swipe_distance = 200;
        workspace_swipe_min_speed_to_force = 0;
      };

      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$filemanager" = "nautilus";
      "$menu" = "rofi -show-icons -show drun";

      general = {
        gaps_in = 6;
        gaps_out = "10,15,15,15";
        border_size = 1;
        "col.active_border" = "rgba(${colors.gruvbox-rgb.bright_orange},1.0) rgba(${colors.gruvbox-rgb.red},1.0) 45deg";
        "col.inactive_border" = "rgba(${colors.gruvbox-rgb.bg4},0.66)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        rounding_power = 3.5;
        blur = {
          enabled = true;
          xray = true;
          size = 4;
          passes = 1;
          popups = true;
        };
        shadow.enabled = false;
      };

      animations = {
        enabled = true;
        bezier = [
          "fluid, 0.15, 0.85, 0.25, 1"
          "snappy, 0.3, 1, 0.4, 1"
        ];

        animation = [
          "windows, 1, 3, fluid, popin 5%"
          "windowsOut, 1, 2.5, snappy"
          "fade, 1, 4, snappy"
          "workspaces, 1, 1.7, snappy, slidevert"
          "layers, 1, 2, snappy, popin 70%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };

      # Layer rules
      layerrule = [
        "blur, waybar" # Blur waybar
        "ignorezero, waybar"
        "ignorealpha 0.5, waybar"
        "noanim, hyprpicker" # fix screenshot border visible
        "noanim, selection" # fix screenshot border visible
      ];

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
          "$mod, L, exec, hyprlock" # Lock screen

          # Move focus with mainMod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Workspace navigation
          "$mod, J, workspace, r+1" # vim motions Down
          "$mod, K, workspace, r-1" # vim motions Up
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
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ --limit 1"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
}
