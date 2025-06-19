{config, ...}: {
  programs.rofi = {
    enable = true;
    font = "Intel One Mono 14";
    modes = [
      "drun"
      "window"
    ];
    terminal = "ghostty";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;

        bg = mkLiteral "transparent";
        bg-alt = mkLiteral "#3c3836";
        fg = mkLiteral "#fbf1c7";
        blue = mkLiteral "#83a598";
        orange = mkLiteral "#d65d0e";
        blue-alt = mkLiteral "#458588";
        orange-alt = mkLiteral "#fe8019";

        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
      };

      "window" = {
        transparency = mkLiteral "'real'";
      };

      "mainbox" = {
        children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        background-color = mkLiteral "@bg-alt";
        children = mkLiteral "[prompt, entry]";
        border-color = mkLiteral "@blue";
      };

      "entry" = {
        background-color = mkLiteral "@blue-alt";
        text-color = mkLiteral "@blue";
        padding = mkLiteral "12px 3px";
      };

      "prompt" = {
        background-color = mkLiteral "inherit";
        padding = mkLiteral "12px 16px 12px 12px";
      };

      "listview" = {
        lines = 10;
      };

      "element" = {
        border = mkLiteral "0 0 0 2px";
        children = mkLiteral "[element-text]";
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
      };

      "element selected" = {
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
