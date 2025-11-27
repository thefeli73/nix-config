{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/git/nix-config/modules/hm/images/nix.png"
        "$HOME/git/nix-config/modules/hm/images/sunset-rocks.png"
        "$HOME/git/nix-config/modules/hm/images/mountains.png"
      ];
      wallpaper = [
        ", $HOME/git/nix-config/modules/hm/images/nix.png"
        "DP-3, $HOME/git/nix-config/modules/hm/images/mountains.png"
        "DP-1, $HOME/git/nix-config/modules/hm/images/sunset-rocks.png"
      ];
    };
  };
}
