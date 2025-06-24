{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktops/hyprland-desktop.nix
    ../../modules/programs.nix
  ];
  # Extend home-manager configuration with host-specific monitor settings
  home-manager.users.schulze.imports = [
    ./hm/hyprland-monitors.nix
    ./hm/hyprlock.nix
    ./hm/hyprpaper.nix
  ];

  networking.hostName = "hurricane";

  # Network security specific to host
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Intel GPU support
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vpl-gpu-rt # Intel GPU support

      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };

  # host-specific packages
  environment.systemPackages = with pkgs; [
    btop
  ];

  # host-specific Systemd services

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
