{pkgs-unstable, ...}: {
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    settings = {
      theme = "gruvbox";
      tui = {
        scroll_speed = 1;
        scroll_acceleration.enabled = false;
      };
    };
  };
}
