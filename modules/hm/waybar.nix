{
  lib,
  osConfig ? null,
  pkgs,
  ...
}: let
  scripts = import ../scripts {inherit pkgs;};
  btopCommand = "${pkgs.ghostty}/bin/ghostty -e ${pkgs.btop}/bin/btop";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  hostName =
    if osConfig == null
    then ""
    else osConfig.networking.hostName or "";
  isWildfire = hostName == "wildfire";
  powerProfileModule =
    if isWildfire
    then "custom/desktop-power-profile"
    else "power-profiles-daemon";
  desktopPowerProfile = scripts.desktop-power-profile;
  powermenu = scripts.rofi-powermenu;
in {
  programs.waybar = {
    enable = true;
    systemd.targets = ["graphical-session.target"];
    settings = [
      {
        output = ["DP-3" "eDP-1"];
        spacing = 8;
        "modules-left" = ["hyprland/workspaces" "mpris" "cava"];
        "modules-center" = ["hyprland/window"];
        "modules-right" = ["idle_inhibitor" "wireplumber" "backlight" "load" "memory" powerProfileModule "battery" "clock" "tray" "custom/powermenu"];

        "hyprland/workspaces" = {
          "all-outputs" = false;
        };
        "hyprland/window" = {
          format = "{title}";
          "max-length" = 60;
          "all-outputs" = true;
          "separate-outputs" = true;
        };
        load = {
          interval = 5;
          format = " {load1}";
          "on-click" = btopCommand;
        };
        memory = {
          interval = 5;
          format = " {used:0.1f}G";
          "tooltip-format" = "RAM: {used:0.1f}/{total:0.1f} GiB ({percentage}%)\nSwap: {swapUsed:0.1f}/{swapTotal:0.1f} GiB ({swapPercentage}%)";
          "on-click" = btopCommand;
        };
        backlight = {
          format = "{icon} {percent}%";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
        };
        clock = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          "format-alt" = " {:%a %F}";
        };
        cava = {
          framerate = 60;
          autosens = 1;
          sensitivity = 2;
          bars = 12;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          method = "pipewire";
          source = "auto";
          stereo = false;
          "bar_delimiter" = 0;
          "noise_reduction" = 0.7;
          "input_delay" = 2;
          "hide_on_silence" = true;
          "sleep_timer" = 3;
          "format-icons" = [" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          actions = {"on-click-right" = "mode";};
        };
        "idle_inhibitor" = {
          format = "{icon}";
          "format-icons" = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
        "power-profiles-daemon" = {
          "format" = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          "tooltip" = true;
          "format-icons" = {
            "default" = "";
            "performance" = "";
            "balanced" = "";
            "power-saver" = "";
          };
        };
        "custom/desktop-power-profile" = lib.mkIf isWildfire {
          exec = "${desktopPowerProfile}/bin/desktop-power-profile status";
          "return-type" = "json";
          interval = 5;
          tooltip = true;
          "on-click" = "${desktopPowerProfile}/bin/desktop-power-profile next";
          "on-click-right" = "${desktopPowerProfile}/bin/desktop-power-profile set powersave";
          "on-click-middle" = "${desktopPowerProfile}/bin/desktop-power-profile set performance";
        };
        "custom/powermenu" = {
          exec = "${pkgs.coreutils}/bin/printf ''";
          format = "{}";
          interval = "once";
          tooltip = true;
          "tooltip-format" = "Power menu";
          "on-click" = "${powermenu}/bin/rofi-powermenu";
        };
        battery = {
          interval = 60;
          states = {
            good = 100;
            normal = 90;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-icons" = ["󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
        };
        mpris = {
          format = "{status_icon} {dynamic}";
          interval = 1;
          "dynamic-len" = 60;
          "status-icons" = {
            playing = "";
            paused = "";
            stopped = "";
          };
          "dynamic-order" = ["title" "artist"];
        };
        wireplumber = {
          "scroll-step" = 1;
          format = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}% ";
          "format-bluetooth-muted" = " {icon}";
          "format-muted" = "";
          "format-icons" = {
            headphone = "";
            "hands-free" = "󰂑";
            headset = "󰂑";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          "on-click" = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click-right" = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
      }
      {
        output = ["HDMI-A-1" "DP-1"];
        spacing = 8;
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = ["hyprland/window"];
        "modules-right" = ["clock"];

        "hyprland/workspaces" = {
          "all-outputs" = false;
        };
        "hyprland/window" = {
          format = "{title}";
          "max-length" = 60;
          "all-outputs" = true;
          "separate-outputs" = true;
        };
        clock = {
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          "format-alt" = " {:%a %F}";
        };
        cava = {
          framerate = 60;
          autosens = 1;
          sensitivity = 2;
          bars = 12;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          method = "pipewire";
          source = "auto";
          stereo = false;
          "bar_delimiter" = 0;
          "noise_reduction" = 0.7;
          "input_delay" = 2;
          "hide_on_silence" = true;
          "sleep_timer" = 3;
          "format-icons" = [" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          actions = {"on-click-right" = "mode";};
        };
        mpris = {
          format = "{status_icon} {dynamic}";
          interval = 1;
          "dynamic-len" = 60;
          "status-icons" = {
            playing = "▶";
            paused = "⏸";
            stopped = "";
          };
          "dynamic-order" = ["title" "artist"];
        };
      }
    ];
    style = ''
      /* colors */
      /* Gruvbox Dark */
      @define-color lightbg   #fbf1c7;
      @define-color bg        #282828;
      @define-color fglight   #282828;
      @define-color bg1       #3c3836;
      @define-color bg2       #504945;
      @define-color bg3       #665c54;
      @define-color bg4       #7c6f64;
      @define-color fg        #ebdbb2;
      @define-color red       #cc241d;
      @define-color green     #98971a;
      @define-color yellow    #d79921;
      @define-color blue      #458588;
      @define-color purple    #b16286;
      @define-color aqua      #689d6a;
      @define-color gray      #a89984;
      @define-color brgray    #928374;
      @define-color brred     #fb4934;
      @define-color brgreen   #b8bb26;
      @define-color bryellow  #fabd2f;
      @define-color brblue    #83a598;
      @define-color brpurple  #d3869b;
      @define-color braqua    #8ec07c;
      @define-color orange    #d65d0e;
      @define-color brorange  #fe8019;
      @define-color tooltipbg rgba(40, 40, 40, 0.9);

      * {
          font-size: 14px;
          border-radius: 6px;
      }

      tooltip {
          font-family: Intel One Mono, Symbols Nerd Font Mono,monospace;
          background-color: @tooltipbg;
          border-radius: 6px;
          border: 1px solid @bg3;
      }

      tooltip label {
          color: @fg;
          text-shadow: none;
      }

      window#waybar {
          font-family: Intel One Mono, Symbols Nerd Font Mono, monospace;
          background-color: transparent;
          border-bottom: 0px;
          color: @fg;
          transition-property: background-color;
          transition-duration: .2s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      window#waybar.empty #window {
          background-color: transparent;
          padding: 0;
          border: none;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          margin: 10px 16px 0;
      }

      button {
          border: none;
      }

      #workspaces {
          background-color: transparent;
          border: 1px solid alpha(@bg4,.7);

      }

      #workspaces button {
          padding: 0 6px;
          background: alpha(@bg,.7);
          color: @fg;
          border-radius: 0;
          transition-property: background-color;
          transition-duration: .2s;
      }

      #workspaces button:first-child {
          border-radius: 6px 0 0 6px;
      }

      #workspaces button:last-child {
          border-radius: 0 6px 6px 0;
      }

      #workspaces button:first-child:last-child {
          border-radius: 6px;
      }

      #workspaces button:hover, #workspaces button.active:hover {
          color: @yellow;
          background: alpha(@bg4,.7);
          box-shadow: inherit;
          text-shadow: inherit;
      }

      #workspaces button.active {
          color: @orange;
          background: alpha(@fg,.7);
      }

      #workspaces button.urgent {
          background: alpha(@purple,.7);
      }

      #idle_inhibitor,
      #cava,
      #scratchpad,
      #mode,
      #clock,
      #battery,
      #backlight,
      #custom-weather,
      #custom-audio_idle_inhibitor,
      #custom-powermenu,
      #wireplumber,
      #tray,
      #mpris,
      #custom-desktop-power-profile,
      #power-profiles-daemon,
      #load,
      #memory {
          color: @fg;
          padding: 0 15px;
          background: alpha(@bg,.7);
          border: 1px solid alpha(@bg4,.7);
      }

      #window {
          padding: 0 15px;
          color: @bg1;
          background: alpha(@fg,.7);
          border: 1px solid alpha(@bg4,.7);
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #cava {
          padding: 0 6px;
      }

      #cava.silent {
          background-color: transparent;
          color: transparent;
          padding: 0;
      }

      #power-profiles-daemon.performance {
          background: alpha(@red,.7);
          color: @fg;
      }

      #power-profiles-daemon.balanced {
          background: alpha(@blue,.7);
          color: @fg;
      }

      #power-profiles-daemon.power-saver {
          background: alpha(@green,.7);
          color: @fg;
      }

      #custom-desktop-power-profile.performance {
          background: alpha(@red,.7);
          color: @fg;
      }

      #custom-desktop-power-profile.balanced {
          background: alpha(@blue,.7);
          color: @fg;
      }

      #custom-desktop-power-profile.powersave {
          background: alpha(@green,.7);
          color: @fg;
      }

      #custom-powermenu:hover {
          background: alpha(@red,.7);
          color: @fg;
      }

      #battery.charging, #battery.plugged, #battery.good {
          background: alpha(@green,.7);
          color: @fg;
      }

      #battery.warning {
          background: alpha(@yellow,.7);
          color: @fglight;
      }

      @keyframes blink {
          to {
              background: alpha(@bg,.7);
              color: @fg;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background: alpha(@red,.7);
          color: @fg;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #wireplumber.muted {
          background: alpha(@blue,.7);
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      #mpris.playing {
          background: alpha(@blue,.7);
          color: @fg;
      }

      #tray menu {
          font-family: sans-serif;
      }
    '';
  };
}
