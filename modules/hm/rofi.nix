{config, ...}: let
  colors = import ../gruvbox-theme.nix;
  inherit (config.lib.formats.rasi) mkLiteral;

  alpha70 = color: "${color}B3";
  rounding = "10px";
in {
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "run"
      "filebrowser"
      "window"
    ];
    terminal = "ghostty";
    font = "Intel One Mono 14";
    location = "center";
    extraConfig = {
      "sorting-method" = "fzf";
      "icon-theme" = "Papirus-dark";
      "show-icons" = true;
      "display-drun" = " Apps";
      "display-run" = " Run";
      "display-filebrowser" = " Files";
      "display-window" = " Windows";
      "drun-display-format" = "{name}";
      "window-format" = "{w} · {c} · {t}";
      "kb-accept-entry" = "Return,KP_Enter";
      "kb-remove-char-back" = "BackSpace,Shift+BackSpace";
      "kb-remove-to-eol" = "";
      "kb-mode-complete" = "";
      "kb-row-down" = "Down,Control+j";
      "kb-row-up" = "Up,Control+k";
      "kb-mode-next" = "Control+l";
      "kb-mode-previous" = "Control+h";
    };
    theme = {
      "*" = {
        background = mkLiteral (alpha70 colors.gruvbox.bg0);
        background-alt = mkLiteral "transparent";
        foreground = mkLiteral colors.gruvbox.fg1;
        selected = mkLiteral (alpha70 colors.gruvbox.bright_blue);
        active = mkLiteral (alpha70 colors.gruvbox.bright_green);
        urgent = mkLiteral (alpha70 colors.gruvbox.bright_red);

        border-colour = mkLiteral (alpha70 colors.gruvbox.bg4);
        handle-colour = mkLiteral "var(selected)";
        background-colour = mkLiteral "var(background)";
        foreground-colour = mkLiteral "var(foreground)";
        alternate-background = mkLiteral "var(background-alt)";
        normal-background = mkLiteral "transparent";
        normal-foreground = mkLiteral "var(foreground)";
        urgent-background = mkLiteral "transparent";
        urgent-foreground = mkLiteral "var(foreground)";
        active-background = mkLiteral "transparent";
        active-foreground = mkLiteral "var(foreground)";
        selected-normal-background = mkLiteral "var(selected)";
        selected-normal-foreground = mkLiteral "var(foreground)";
        selected-urgent-background = mkLiteral "var(urgent)";
        selected-urgent-foreground = mkLiteral "var(foreground)";
        selected-active-background = mkLiteral "var(active)";
        selected-active-foreground = mkLiteral "var(foreground)";
        alternate-normal-background = mkLiteral "transparent";
        alternate-normal-foreground = mkLiteral "var(foreground)";
        alternate-urgent-background = mkLiteral "transparent";
        alternate-urgent-foreground = mkLiteral "var(foreground)";
        alternate-active-background = mkLiteral "transparent";
        alternate-active-foreground = mkLiteral "var(foreground)";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "var(foreground)";
      };

      "window" = {
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        width = mkLiteral "800px";
        border = mkLiteral "1px";
        border-color = mkLiteral "@border-colour";
        border-radius = mkLiteral rounding;
        background-color = mkLiteral "@background-colour";
      };

      "mainbox" = {
        padding = mkLiteral "20px";
        spacing = mkLiteral "18px";
        children = mkLiteral ''[ "inputbar", "mode-switcher", "message", "listview" ]'';
      };

      "inputbar" = {
        padding = mkLiteral "14px 12px";
        spacing = mkLiteral "18px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "transparent";
        children = mkLiteral ''[ "textbox-prompt-colon", "entry" ]'';
      };

      "textbox-prompt-colon" = {
        str = "";
        expand = false;
        text-color = mkLiteral "@selected";
        vertical-align = mkLiteral "0.5";
      };

      "entry" = {
        expand = false;
        padding = mkLiteral "0px 0px 6px 0px";
        placeholder = "Type to search...";
        placeholder-color = mkLiteral "@foreground-colour";
        horizontal-align = mkLiteral "0";
        vertical-align = mkLiteral "0.5";
      };

      "mode-switcher" = {
        spacing = mkLiteral "12px";
      };

      "button" = {
        padding = mkLiteral "12px 16px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };

      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };

      "message" = {
        padding = mkLiteral "10px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "transparent";
      };

      "textbox" = {
        text-color = mkLiteral "@foreground-colour";
      };

      "listview" = {
        columns = 1;
        lines = 8;
        cycle = false;
        dynamic = true;
        scrollbar = false;
        spacing = mkLiteral "8px";
      };

      "element" = {
        padding = mkLiteral "12px";
        spacing = mkLiteral "14px";
        border-radius = mkLiteral "8px";
      };

      "element-icon" = {
        size = mkLiteral "24px";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
      };

      "element normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-foreground";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@selected-urgent-foreground";
      };
      "element selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-foreground";
      };
      "element alternate.normal" = {
        background-color = mkLiteral "@alternate-normal-background";
        text-color = mkLiteral "@alternate-normal-foreground";
      };
      "element alternate.urgent" = {
        background-color = mkLiteral "@alternate-urgent-background";
        text-color = mkLiteral "@alternate-urgent-foreground";
      };
      "element alternate.active" = {
        background-color = mkLiteral "@alternate-active-background";
        text-color = mkLiteral "@alternate-active-foreground";
      };
    };
  };

  xdg.configFile."rofi/powermenu-type1-style1-gruvbox.rasi".text = ''
    * {
      background: ${alpha70 colors.gruvbox.bg0};
      background-alt: transparent;
      foreground: ${colors.gruvbox.fg1};
      selected: ${alpha70 colors.gruvbox.bright_blue};
      active: ${alpha70 colors.gruvbox.bright_green};
      urgent: ${alpha70 colors.gruvbox.bright_red};
      border-colour: ${alpha70 colors.gruvbox.bg4};

      background-color: transparent;
      text-color: @foreground;
      font: "Intel One Mono 14";
    }

    window {
      location: northeast;
      anchor: northeast;
      x-offset: -16px;
      y-offset: 10px;
      width: 400px;
      border: 1px;
      border-color: @border-colour;
      border-radius: ${rounding};
      background-color: @background;
    }

    mainbox {
      padding: 20px;
      spacing: 18px;
      children: [ "inputbar", "message", "listview" ];
    }

    inputbar {
      border-radius: ${rounding};
      children: [ "textbox-prompt-colon", "prompt" ];
    }

    textbox-prompt-colon {
      str: "";
      padding: 10px 14px;
      background-color: @urgent;
      text-color: @foreground;
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    prompt {
      padding: 14px 20px;
      background-color: @active;
      text-color: @foreground;
      vertical-align: 0.5;
    }

    message {
      padding: 12px 16px;
      border-radius: ${rounding};
      background-color: transparent;
    }

    textbox {
      text-color: @foreground;
    }

    listview {
      columns: 1;
      lines: 5;
      cycle: false;
      dynamic: false;
      scrollbar: false;
      spacing: 10px;
    }

    element {
      padding: 12px;
      border-radius: ${rounding};
      background-color: transparent;
      text-color: @foreground;
    }

    element selected.normal {
      background-color: @selected;
      text-color: @foreground;
    }

    element-text {
      text-color: inherit;
    }
  '';
}
