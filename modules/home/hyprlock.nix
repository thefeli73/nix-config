let
  colors = import ../gruvbox-theme.nix;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        # Background image is set in host specific configuration
        #path = "$HOME/git/nixos/modules/home/images/sky.png";
        blur_size = 3;
        blur_passes = 4;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      # GENERAL
      general = {
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # INPUT FIELD
      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(${colors.gruvbox-rgb.blue}, 0.8)";
        inner_color = "rgba(${colors.gruvbox-rgb.bg0}, 0.4)";
        font_color = "rgba(${colors.gruvbox-rgb.fg1}, 1.0)";
        placeholder_text = "Welcome $USER";
        fade_on_empty = false;
        rounding = -1;
        check_color = "rgba(${colors.gruvbox-rgb.yellow}, 1.0)";
        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      # DATE
      label = [
        {
          monitor = "";
          text = "cmd[update:10000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(${colors.gruvbox-rgb.fg2}, 1.0)";
          font_size = 34;
          font_family = "Intel One Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # TIME
        {
          monitor = "";
          text = "cmd[update:2000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(${colors.gruvbox-rgb.fg1}, 1.0)";
          font_size = 94;
          font_family = "Intel One Mono Bold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
