{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home Manager configuration
  home-manager = {
    backupFileExtension = "backupHM";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.schulze.imports = [
      ./home/hyprland.nix
      ./home/home-manager.nix
    ];
  };

  # Define the main user account
  users = {
    users.schulze = {
      isNormalUser = true;
      description = "Felix Schulze";
      extraGroups = ["networkmanager" "wheel" "docker" "plugdev"];
      shell = pkgs.fish;
    };
    groups.libvirtd.members = ["schulze"];
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    # Enable networking
    networkmanager.enable = true;

    # Network security
    # enable firewall and block all ports
    firewall.enable = true;
  };

  # disable coredump that could be exploited later
  # and also slow down the system when something crash
  systemd.coredump.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  services = {
    # Enable CUPS to print documents.
    printing.enable = false;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # enable antivirus clamav and keep the signatures' database updated
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };

  # Realtime scheduling priority for audio
  security.rtkit.enable = true;
  # Polkit agent (authentication dialogs)
  security.polkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Automatic system upgrades
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Fonts
  fonts.packages = with pkgs; [
    intel-one-mono
    noto-fonts
    noto-fonts-emoji
  ];

  # This improves touchscreen support and enables additional touchpad gestures. It also enables smooth scrolling as opposed to the stepped scrolling that Firefox has by default
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # create system-wide executables firefox and chromium
  # that will wrap the real binaries so everything work out of the box.
  # enable firejail
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      chromium = {
        executable = "${pkgs.lib.getBin pkgs.ungoogled-chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
      };
    };
  };
  # Yubikey Settings
  services.yubikey-agent.enable = true;
  security.pam.u2f.enable = true;
}
