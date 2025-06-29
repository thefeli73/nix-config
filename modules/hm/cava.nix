let
  colors = import ../gruvbox-theme.nix;
in {
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 60;
        bar_spacing = 0;
      };
      input.method = "pipewire";
      output.channels = "mono";
      color = {
        gradient = 1;
        gradient_count = 2;
        gradient_color_1 = "'${colors.gruvbox.aqua}'";
        gradient_color_2 = "'${colors.gruvbox.orange}'";
      };
      smoothing.noise_reduction = 0.8;
    };
  };
}
