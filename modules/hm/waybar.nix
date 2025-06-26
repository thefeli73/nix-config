{
  programs.waybar = {
    enable = true;
    settings = [
      {
        output = ["DP-3"];
        spacing = 5;
        "modules-left" = ["sway/workspaces" "sway/window" "sway/mode" "sway/scratchpad"];
        "modules-center" = [];
        "modules-right" = ["cava" "mpris" "custom/audio_idle_inhibitor" "idle_inhibitor" "wireplumber" "custom/weather" "clock" "tray"];
        "sway/workspaces" = {
          "all-outputs" = false;
          "warp-on-scroll" = false;
          "enable-bar-scroll" = true;
          "disable-scroll-wraparound" = true;
          format = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "9" = "";
            "10" = "";
          };
        };
        "sway/window" = {
          format = "{title}";
          "max-length" = 60;
          "all-outputs" = true;
        };
        cava = {
          framerate = 30;
          autosens = 1;
          bars = 12;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          method = "pulse";
          source = "auto";
          stereo = true;
          "bar_delimiter" = 0;
          "noise_reduction" = 0.77;
          "input_delay" = 2;
          "hide_on_silence" = true;
          "format-icons" = [" " "▂" "▃" "▄" "▅" "▆" "▇" "█"];
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
        "custom/audio_idle_inhibitor" = {
          format = "{icon}";
          exec = "sway-audio-idle-inhibit --dry-print-both-waybar --ignore-source-outputs cava";
          "exec-if" = "which sway-audio-idle-inhibit";
          "return-type" = "json";
          "format-icons" = {
            output = "";
            input = "";
            "output-input" = "  ";
            none = "";
          };
        };
        "idle_inhibitor" = {
          format = "{icon}";
          "format-icons" = {
            activated = "";
            deactivated = "";
          };
        };
        "sway/mode" = {format = "{}";};
        "sway/scratchpad" = {
          format = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = ["" ""];
          tooltip = true;
          "tooltip-format" = "{app}: {title}";
        };
        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
        load = {format = " {}";};
        clock = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          "format-alt" = " {:%a %F}";
        };
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "/home/origincode/.local/bin/wttrbar -l zh-tw --icon-family nerd --location Seattle";
          "return-type" = "json";
        };
        wireplumber = {
          "scroll-step" = 5;
          format = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}% ";
          "format-bluetooth-muted" = "󰆪 {icon}";
          "format-muted" = "󰆪";
          "format-icons" = {
            headphone = "";
            "hands-free" = "󰂑";
            headset = "󰂑";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click-right" = "pavucontrol";
        };
      }
      {
        output = ["HDMI-A-1"];
        spacing = 4;
        "modules-left" = ["sway/workspaces" "sway/window" "sway/mode" "sway/scratchpad"];
        "modules-center" = [];
        "modules-right" = ["cava" "mpris" "custom/audio_idle_inhibitor" "idle_inhibitor" "wireplumber" "backlight" "custom/weather" "clock" "battery" "tray"];
        "sway/workspaces" = {
          "all-outputs" = false;
          "warp-on-scroll" = false;
          "enable-bar-scroll" = true;
          "disable-scroll-wraparound" = true;
          format = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "9" = "";
            "10" = "";
          };
        };
        "sway/window" = {
          format = "{title}";
          "max-length" = 60;
          "all-outputs" = true;
        };
        cava = {
          framerate = 30;
          autosens = 1;
          bars = 14;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          method = "pulse";
          source = "auto";
          stereo = true;
          "bar_delimiter" = 0;
          "noise_reduction" = 0.77;
          "input_delay" = 2;
          "hide_on_silence" = true;
          "format-icons" = [" " "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          actions = {"on-click-right" = "mode";};
        };
        mpris = {
          player = "Feishin";
          format = " {status_icon} {dynamic}";
          interval = 1;
          "dynamic-len" = 60;
          "status-icons" = {
            playing = "▶";
            paused = "⏸";
            stopped = "";
          };
          "dynamic-order" = ["title" "artist"];
        };
        "custom/audio_idle_inhibitor" = {
          format = "{icon}";
          exec = "sway-audio-idle-inhibit --dry-print-both-waybar --ignore-source-outputs cava";
          "exec-if" = "which sway-audio-idle-inhibit";
          "return-type" = "json";
          "format-icons" = {
            output = "";
            input = "";
            "output-input" = "  ";
            none = "";
          };
        };
        "idle_inhibitor" = {
          format = "{icon}";
          "format-icons" = {
            activated = "";
            deactivated = "";
          };
        };
        "sway/mode" = {format = "{}";};
        "sway/scratchpad" = {
          format = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = ["" ""];
          tooltip = true;
          "tooltip-format" = "{app}: {title}";
        };
        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
        load = {format = " {}";};
        clock = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          "format-alt" = " {:%a %F}";
        };
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "wttrbar -l zh-tw --icon-family nerd";
          "return-type" = "json";
        };
        backlight = {
          format = "{icon} {percent}%";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰃨 {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-icons" = ["" "" "" "" ""];
        };
        wireplumber = {
          "scroll-step" = 5;
          format = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}% ";
          "format-bluetooth-muted" = "󰆪 {icon}";
          "format-muted" = "󰆪";
          "format-icons" = {
            headphone = "";
            "hands-free" = "󰂑";
            headset = "󰂑";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click-right" = "pavucontrol";
        };
      }
      {
        output = [];
        spacing = 4;
        "modules-left" = ["sway/workspaces" "sway/mode" "sway/scratchpad"];
        "modules-center" = [];
        "modules-right" = ["sway/window" "clock"];
        "sway/workspaces" = {
          "all-outputs" = false;
          "warp-on-scroll" = true;
          "enable-bar-scroll" = true;
          format = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "9" = "";
            "10" = "";
          };
        };
        "sway/window" = {
          format = "{title}";
          "max-length" = 40;
          "all-outputs" = true;
        };
        "sway/mode" = {format = "{}";};
        "sway/scratchpad" = {
          format = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = ["" ""];
          tooltip = true;
          "tooltip-format" = "{app}: {title}";
        };
        clock = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          "format-alt" = " {:%a %F}";
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
      @define-color tooltipbg rgba(40, 40, 40, 0.8);

      * {
          font-size: 14px;
          border-radius: 5px;
      }

      tooltip {
          font-family: Intel One Mono, monospace;
          background-color: @tooltipbg;
          border-radius: 5px;
          border: 1px solid @bg3;
      }

      tooltip label {
          color: @fg;
          text-shadow: none;
      }

      window#waybar {
          font-family: Iosevka Nerd Font Propo, monospace;
          background-color: transparent;
          border-bottom: 0px;
          color: @fg;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      window#waybar.empty #window {
          background-color: transparent;
          padding: 0;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      .modules-right {
          margin: 10px 10px 0 0;
      }
      .modules-center {
          margin: 10px 0 0 0;
      }
      .modules-left {
          margin: 10px 0 0 10px;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          /* box-shadow: inset 0 -3px transparent; */
          border: none;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      /*
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px @fg;
      } */

      #workspaces {
          background-color: @bg;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: @fg;
          border-radius: 0;
      }

      #workspaces button:first-child {
          border-radius: 5px 0 0 5px;
      }

      #workspaces button:last-child {
          border-radius: 0 5px 5px 0;
      }

      #workspaces button:first-child:last-child {
          border-radius: 5px;
      }

      #workspaces button:hover {
          color: @yellow;
      }

      #workspaces button.focused {
          background-color: @bg3;
          /* box-shadow: inset 0 -3px #ffffff; */
      }

      #workspaces button.urgent {
          background-color: @purple;
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
      #wireplumber,
      #tray,
      #mpris,
      #load {
          padding: 0 10px;
          background-color: @bg;
          color: @fg;
      }

      #window {
          padding: 0 10px;
          background-color: @fg;
          color: @bg1;
      }

      #mode {
          background-color: @aqua;
          color: @fglight;
          /* box-shadow: inset 0 -3px #ffffff; */
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
          padding: 0 5px;
      }

      #battery.charging, #battery.plugged {
          background-color: @green;
          color: @fglight;
      }

      @keyframes blink {
          to {
              background-color: @bg;
              color: @fg;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: @red;
          color: @fg;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #wireplumber.muted {
          background-color: @blue;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      #mpris.playing {
          background-color: @yellow;
          color: @fglight;
      }

      #tray menu {
          font-family: sans-serif;
      }

      #scratchpad.empty {
          background: transparent;
          padding: 0;
      }
    '';
  };
}
