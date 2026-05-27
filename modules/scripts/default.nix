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
}
