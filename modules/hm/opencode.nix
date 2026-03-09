{
  pkgs,
  inputs,
  ...
}: {
  programs.opencode = {
    enable = true;
    package = inputs.opencode.packages.${pkgs.system}.default;
    settings = {
      theme = "gruvbox";
      tui = {
        scroll_speed = 1;
        scroll_acceleration.enabled = false;
      };
    };
  };
}
