{...}: let
  colors = import ../gruvbox-theme.nix;
in {
  services.mako = {
    enable = true;
    settings = {
      font = "Intel One Mono 10";
      actions = true;
      anchor = "bottom-center";
      background-color = "${colors.gruvbox.bg0}";
      text-color = "${colors.gruvbox.fg0}";
      border-color = "${colors.gruvbox.yellow}";
      border-radius = 5;
      default-timeout = 60000;
      height = 100;
      width = 300;
      icons = true;
      layer = "top";
      margin = 5;
      padding = 15;
      border-size = 1;
      markup = true;
    };
  };
}
