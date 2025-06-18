{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark";
    font = "Intel One Mono";
    modes = [
      "window"
      "drun"
      "calc"
      "emoji"
    ];
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
    ];
    terminal = "\${pkgs.ghostty}/bin/ghostty";
  };
}
