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
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        margin = 0;
        padding = 0;
        spacing = 0;

        bg0 = mkLiteral "#2828289A";
        bg1 = mkLiteral "#3c3836";
        bg2 = mkLiteral "#50494580";
        bg3 = mkLiteral "#665c549A";

        fg0 = mkLiteral "#fbf1c7";
        fg1 = mkLiteral "#ebdbb2";
        fg2 = mkLiteral "#d5c4a1";
        fg3 = mkLiteral "#bdae93";

        blue = mkLiteral "#83a598";
        orange = mkLiteral "#d65d0e";
        blue-alt = mkLiteral "#458588";
        orange-alt = mkLiteral "#fe8019";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        #transparency = mkLiteral "'real'";

        width = mkLiteral "480";
        border-radius = mkLiteral "8px";
        border = mkLiteral "1px solid @bg3";
      };

      "mainbox" = {
        padding = mkLiteral "12px";
        #children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        background-color = mkLiteral "@bg1";
        border-color = mkLiteral "@bg3";

        border = mkLiteral "2px";
        border-radius = mkLiteral "4px";

        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = mkLiteral "[prompt, entry]";
      };

      "prompt" = {
        text-color = mkLiteral "@fg2";
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
        #border = mkLiteral "0 0 0 2px";
        #spacing = mkLiteral "8px";
      };

      "element normal active" = {
        text-color = mkLiteral "@bg3";
      };

      "element alternate active" = {
        text-color = mkLiteral "@bg3";
      };

      "element selected normal, element selected active" = {
        background-color = mkLiteral "@bg3";
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
