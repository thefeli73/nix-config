{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/git/nix-config/modules/hm/images/nix.png"
        "$HOME/git/nix-config/modules/hm/images/sunset-rocks.png"
      ];
      wallpaper = [
        ", $HOME/git/nix-config/modules/hm/images/nix.png"
        "DP-3, $HOME/git/nix-config/modules/hm/images/sunset-rocks.png"
      ];
    };
  };
}
