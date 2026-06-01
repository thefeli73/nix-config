let
  nixLogo = ../../../modules/hm/images/nix.png;
  forest3 = ../../../modules/hm/images/forest-3.png;
  forest4 = ../../../modules/hm/images/forest-4.jpg;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = "${nixLogo}";
        }
        {
          monitor = "DP-3";
          path = "${forest3}";
        }
        {
          monitor = "HDMI-A-1";
          path = "${forest4}";
        }
        {
          monitor = "eDP-1";
          path = "${forest4}";
        }
      ];
    };
  };
}
