let
  nixLogo = ../../../modules/hm/images/nix.png;
  sunsetRocks = ../../../modules/hm/images/sunset-rocks.png;
  mountains = ../../../modules/hm/images/mountains.png;
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
          path = "${mountains}";
        }
        {
          monitor = "DP-1";
          path = "${sunsetRocks}";
        }
      ];
    };
  };
}
