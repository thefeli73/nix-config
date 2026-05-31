let
  nixLogo = ../../../modules/hm/images/nix.png;
  forest = ../../../modules/hm/images/forest.png;
  moss = ../../../modules/hm/images/moss.png;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "${nixLogo}";
        }
        {
          monitor = "DP-3";
          path = "${forest}";
        }
        {
          monitor = "HDMI-A-1";
          path = "${moss}";
        }
        {
          monitor = "eDP-1";
          path = "${moss}";
        }
      ];
    };
  };
}
