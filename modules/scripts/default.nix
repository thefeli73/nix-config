{pkgs}: rec {
  amdgpu-force-profile = pkgs.writeShellApplication {
    name = "amdgpu-force-profile";
    text = builtins.readFile ./amdgpu-force-profile.sh;
  };

  hyprland-display-profile = pkgs.writeShellApplication {
    name = "hyprland-display-profile";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.hyprland
      pkgs.jq
    ];
    text = builtins.readFile ./hyprland-display-profile.sh;
  };

  desktop-power-profile = pkgs.writeShellApplication {
    name = "desktop-power-profile";
    runtimeInputs = [
      hyprland-display-profile
      pkgs.coreutils
      pkgs.power-profiles-daemon
    ];
    text = builtins.readFile ./desktop-power-profile.sh;
  };

  hyprshot-sdr = pkgs.writeShellApplication {
    name = "hyprshot-sdr";
    runtimeInputs = [
      hyprland-display-profile
      pkgs.hyprshot
    ];
    text = builtins.readFile ./hyprshot-sdr.sh;
  };

  rofi-launcher = pkgs.writeShellApplication {
    name = "rofi-launcher";
    runtimeInputs = [
      pkgs.rofi
      rofi-file-search
    ];
    text = builtins.readFile ./rofi-launcher.sh;
  };

  rofi-file-search = pkgs.writeShellApplication {
    name = "rofi-file-search";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.fd
      pkgs.nautilus
      pkgs.xdg-utils
    ];
    text = builtins.readFile ./rofi-file-search.sh;
  };

  rofi-powermenu = pkgs.writeShellApplication {
    name = "rofi-powermenu";
    runtimeInputs = [
      pkgs.procps
      pkgs.coreutils
      pkgs.gnused
      pkgs.hyprland
      pkgs.hyprlock
      pkgs.rofi
      pkgs.systemd
    ];
    text = builtins.readFile ./rofi-powermenu.sh;
  };
}
