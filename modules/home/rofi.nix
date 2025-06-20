{config, ...}: {
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "window"
    ];
    terminal = "ghostty";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "Intel One Mono 14";
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;

        bg0 = mkLiteral "#282828f2";
        bg1 = mkLiteral "#3c3836";
        bg2 = mkLiteral "#50494580";
        bg3 = mkLiteral "#665c54f2";

        fg0 = mkLiteral "#fbf1c7";
        fg1 = mkLiteral "#ebdbb2";
        fg2 = mkLiteral "#d5c4a1";
        fg3 = mkLiteral "#bdae93";

        blue = mkLiteral "#83a598";
        orange = mkLiteral "#d65d0e";
        blue-alt = mkLiteral "#458588";
        orange-alt = mkLiteral "#fe8019";

        background-color = mkLiteral "@bg0";
        text-color = mkLiteral "@fg0";
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        #transparency = mkLiteral "'real'";
      };

      "mainbox" = {
        padding = mkLiteral "12px";
        #children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        background-color = mkLiteral "@bg1";
        border-color = mkLiteral "@bg3";

        border = mkLiteral "2px";

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

      "listview" = {
        background-color = mkLiteral "transparent";
        margin = mkLiteral "12px 0 0";
        columns = 1;
        lines = 10;
      };

      "element" = {
        border = mkLiteral "0 0 0 2px";
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
      };

      "element selected" = {
        text-color = mkLiteral "@bg1";
        border-color = mkLiteral "@orange";
      };

      "element-icon" = {
        size = mkLiteral "1em";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = {
        padding = mkLiteral "10px";
      };

      "element-text.selected" = {
        background-color = mkLiteral "@orange-alt";
        text-color = mkLiteral "@orange";
      };
    };
  };
}
