{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktops/gnome-desktop.nix
    ../../modules/programs.nix
  ];

  # Encrypted drive
  boot.initrd.luks.devices."luks-1728f038-43a6-4e0d-b7dd-19a4c1083605".device = "/dev/disk/by-uuid/1728f038-43a6-4e0d-b7dd-19a4c1083605";

  networking.hostName = "wildfire";

  hardware = {
    steam-hardware.enable = true;
    graphics.enable = true;
  };

  # Network security specific to wildfire
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  # Wildfire-specific packages
  environment.systemPackages = with pkgs; [
    lact
    multiviewer-for-f1
    wasabiwallet
    prismlauncher
    davinci-resolve
    ardour
  ];

  # Wildfire-specific Systemd services
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
}
