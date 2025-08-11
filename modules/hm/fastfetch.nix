{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = " ";
      };
      logo = {
        source = "\${../../images/nixos-logo.png}";
        type = "kitty-direct";
        width = 33;
        padding = {
          top = 2;
        };
      };
      modules = [
        {
          type = "title";
          key = "╭─";
          format = "{user-name}@{host-name}";
          keyColor = "blue";
        }
        {
          type = "os";
          key = "├─";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "├─";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "├─󰏖";
          keyColor = "blue";
        }
        {
          type = "media";
          key = "├─󰝚";
          keyColor = "blue";
        }
        {
          type = "localip";
          key = "├─󰩟";
          compact = true;
          keyColor = "blue";
        }
        {
          type = "publicip";
          key = "├─󰩠";
          keyColor = "blue";
          timeout = 1000;
        }
        {
          type = "uptime";
          key = "╰─󰅐";
          keyColor = "blue";
        }
        "break"

        {
          type = "host";
          key = "╭─󰌢";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "├─󰻠";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "├─󰍛";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "swap";
          key = "├─󰓡";
          keyColor = "green";
        }
        {
          type = "display";
          key = "├─󰍹";
          keyColor = "green";
        }
        {
          type = "battery";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "poweradapter";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "gamepad";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "bluetooth";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "sound";
          key = "╰─";
          keyColor = "green";
        }
        "break"
        {
          type = "shell";
          key = "╭─";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "terminalfont";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "de";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "lm";
          key = "├─󰧨";
          keyColor = "yellow";
        }
        {
          type = "theme";
          key = "├─󰉼";
          keyColor = "yellow";
        }
        {
          type = "icons";
          key = "╰─󰀻";
          keyColor = "yellow";
        }
      ];
    };
  };
}
