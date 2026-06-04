let
  nixLogo = ./images/nix.png;
  forest1 = ./images/forest-1.jpg;
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
          path = "${forest1}";
        }
        {
          monitor = "DP-1";
          path = "${forest1}";
        }
        {
          monitor = "HDMI-A-1";
          path = "${forest1}";
        }
        {
          monitor = "eDP-1";
          path = "${forest1}";
        }
      ];
    };
  };
}
