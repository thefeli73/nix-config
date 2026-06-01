let
  nixLogo = ../../../modules/hm/images/nix.png;
  forest1 = ../../../modules/hm/images/forest-1.jpg;
  forest2 = ../../../modules/hm/images/forest-2.png;
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
          path = "${forest2}";
        }
      ];
    };
  };
}
