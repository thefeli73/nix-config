{config, ...}: let
  colors = import ../gruvbox-theme.nix;
in {
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "window"
    ];
    terminal = "ghostty";
    font = "Intel One Mono 14";
    location = "center";
    extraConfig = {
      "sorting-method" = "fzf";
      "icon-theme" = "Papirus-dark";
      "display-drun" = " Apps ";
      "display-window" = " Window ";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        margin = 0;
        padding = 0;
        spacing = 0;

        bg0 = mkLiteral "${colors.gruvbox.bg0}9A";
        bg1 = mkLiteral "${colors.gruvbox.bg1}";
        bg2 = mkLiteral "${colors.gruvbox.bg2}9A";
        bg3 = mkLiteral "${colors.gruvbox.bg3}9A";

        fg0 = mkLiteral "${colors.gruvbox.fg0}";
        fg1 = mkLiteral "${colors.gruvbox.fg1}";
        fg2 = mkLiteral "${colors.gruvbox.fg2}";
        fg3 = mkLiteral "${colors.gruvbox.fg3}";

        blue = mkLiteral "${colors.gruvbox.blue}";
        orange = mkLiteral "${colors.gruvbox.orange}";
        brightOrange = mkLiteral "${colors.gruvbox.bright_orange}";
        brightBlue = mkLiteral "${colors.gruvbox.bright_blue}9A";
        red = mkLiteral "${colors.gruvbox.red}";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        #transparency = mkLiteral "'real'";

        width = mkLiteral "480";
        border-radius = mkLiteral "8px";
        border = mkLiteral "1px";
        border-color = mkLiteral "@red";
      };

      "mainbox" = {
        padding = mkLiteral "12px";
        #children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        background-color = mkLiteral "@bg1";
        border-color = mkLiteral "@orange";

        border = mkLiteral "2px";
        border-radius = mkLiteral "4px";

        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = mkLiteral "[prompt, entry]";
      };

      "prompt" = {
        text-color = mkLiteral "@brightOrange";
      };

      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral "@fg3";
      };

      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "4px";
        border-color = mkLiteral "@bg2";
        background-color = mkLiteral "@bg2";
      };

      "textbox" = {
        padding = mkLiteral "8px 24px";
      };

      "listview" = {
        background-color = mkLiteral "transparent";
        margin = mkLiteral "12px 0 0";
        lines = 10;
        columns = 1;
      };

      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "4px";
        #spacing = mkLiteral "8px";
      };

      "element normal active" = {
        text-color = mkLiteral "@bg3";
      };

      "element alternate active" = {
        text-color = mkLiteral "@bg3";
      };

      "element selected normal, element selected active" = {
        background-color = mkLiteral "@brightBlue";
        border = mkLiteral "2px";
        border-color = mkLiteral "@blue";
      };

      "element-icon" = {
        size = mkLiteral "1em";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
        #padding = mkLiteral "10px";
      };

      "element selected" = {
        #text-color = mkLiteral "@bg1";
        #border-color = mkLiteral "@orange";
      };

      "element-text.selected" = {
        #background-color = mkLiteral "@orange-alt";
        #text-color = mkLiteral "@orange";
      };
    };
  };
}
