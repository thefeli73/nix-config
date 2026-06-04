{pkgs, ...}: let
  colors = import ../gruvbox-theme.nix;
  forest5 = ./images/forest-5.jpg;
  forest6 = ./images/forest-6.jpg;
  randomHyprlock = pkgs.writeShellScriptBin "random-hyprlock" ''
    set -eu

    : "''${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR is not set}"

    background_link="$XDG_RUNTIME_DIR/hyprlock-background"
    background_image="$(${pkgs.coreutils}/bin/printf '%s\n%s\n' \
      "${forest5}" \
      "${forest6}" \
      | ${pkgs.coreutils}/bin/shuf -n 1)"

    ${pkgs.coreutils}/bin/ln -sf "$background_image" "$background_link"
    exec ${pkgs.hyprlock}/bin/hyprlock "$@"
  '';
in {
  home.packages = [randomHyprlock];

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "$XDG_RUNTIME_DIR/hyprlock-background";
      };

      # GENERAL
      general = {
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # INPUT FIELD
      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 1;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(${colors.gruvbox-rgb.bg4}, 0.7)";
        inner_color = "rgba(${colors.gruvbox-rgb.bg0}, 0.7)";
        font_color = "rgba(${colors.gruvbox-rgb.fg1}, 1.0)";
        placeholder_text = "Welcome $USER";
        fade_on_empty = false;
        rounding = 10;
        check_color = "rgba(${colors.gruvbox-rgb.yellow}, 1.0)";
        hide_input = false;
        position = "0, 110";
        halign = "center";
        valign = "bottom";
      };

      # DATE
      label = [
        {
          monitor = "";
          text = "cmd[update:10000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(${colors.gruvbox-rgb.fg2}, 1.0)";
          font_size = 34;
          font_family = "Intel One Mono";
          position = "45, 75";
          halign = "left";
          valign = "bottom";
        }

        # TIME
        {
          monitor = "";
          text = "cmd[update:2000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(${colors.gruvbox-rgb.fg1}, 1.0)";
          font_size = 94;
          font_family = "Intel One Mono Bold";
          position = "40, 150";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };
}
