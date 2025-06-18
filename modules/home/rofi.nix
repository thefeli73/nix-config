{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark";
    font = "Intel One Mono";
    modes = [
      "drun"
      "window"
    ];
    terminal = "\${pkgs.ghostty}/bin/ghostty";
  };
}
