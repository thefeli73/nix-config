{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktops/hyprland-desktop.nix
    ../../modules/programs.nix
    ./vpn.nix
  ];
  # Extend home-manager configuration with host-specific monitor settings
  home-manager.users.schulze.imports = [
    ./hm/hyprland-monitors.nix
    ./hm/hyprlock.nix
    ./hm/hyprpaper.nix
  ];

  networking.hostName = "wildfire";

  # AMD GPU support
  boot.initrd.kernelModules = ["amdgpu"]; # AMD GPU kernel module
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd # OpenCL
  ];

  # Network security specific to host
  networking.firewall.allowedTCPPorts = [
    8081 # Expo
  ];
  networking.firewall.allowedUDPPorts = [];

  # host-specific packages
  environment.systemPackages = with pkgs; [
    lact
    multiviewer-for-f1
    wasabiwallet
    prismlauncher
    davinci-resolve
    ardour
    btop-rocm
  ];

  # host-specific Systemd services
  systemd = {
    packages = with pkgs; [lact];
    services.lact = {
      description = "AMDGPU Control Daemon";
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
      };
      enable = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
