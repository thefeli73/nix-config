{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/git/nix-config/modules/hm/images/nix.png"
        "$HOME/git/nix-config/modules/hm/images/forest.png"
      ];
      wallpaper = [
        ", $HOME/git/nix-config/modules/hm/images/nix.png"
        "DP-3, $HOME/git/nix-config/modules/hm/images/forest.png"
        "HDMI-A-1, $HOME/git/nix-config/modules/hm/images/forest.png"
        "eDP-1, $HOME/git/nix-config/modules/hm/images/forest.png"
      ];
    };
  };
}
