{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktops/hyprland-desktop.nix
    ../../modules/programs.nix
  ];
  # Extend home-manager configuration with host-specific monitor settings
  home-manager.users.schulze.imports = [
    ./hyprland-monitors.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  # Encrypted drive
  boot.initrd.luks.devices."luks-1728f038-43a6-4e0d-b7dd-19a4c1083605".device = "/dev/disk/by-uuid/1728f038-43a6-4e0d-b7dd-19a4c1083605";

  networking.hostName = "wildfire";

  hardware = {
    steam-hardware.enable = true;
    graphics.enable = true;
  };

  # AMD GPU kernel module
  boot.initrd.kernelModules = ["amdgpu"];

  # Network security specific to host
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  # host-specific packages
  environment.systemPackages = with pkgs; [
    lact
    multiviewer-for-f1
    wasabiwallet
    prismlauncher
    davinci-resolve
    ardour
  ];

  # host-specific Systemd services
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
