let
  colors = import ../gruvbox-theme.nix;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "$HOME/git/nixos/modules/home/images/sunset-rocks.png";
        blur_passes = 2;
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
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = colors.gruvbox.fg1;
        fade_on_empty = false;
        rounding = -1;
        check_color = colors.gruvbox.yellow;
        placeholder_text = "<i><span foreground=\"${colors.gruvbox.fg3}\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      # DATE
      label = [
        {
          monitor = "";
          text = "cmd[update:10000] $(date +\"%A, %B %d\")";
          color = colors.gruvbox.fg2;
          font_size = 34;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # TIME
        {
          monitor = "";
          text = "cmd[update:2000] $(date +\"%-I:%M\")";
          color = colors.gruvbox.fg1;
          font_size = 94;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
