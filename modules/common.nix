# Common system configuration shared across all hosts
# This module contains the base settings that every system should have
{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    # Import Home Manager as a NixOS module for user-specific configurations
    inputs.home-manager.nixosModules.home-manager
  ];

  # ================================
  # HOME MANAGER INTEGRATION
  # ================================
  # Configure Home Manager to manage user-specific dotfiles and applications
  home-manager = {
    # Create backup files when Home Manager would overwrite existing files
    backupFileExtension = "backupHM";
    # Use system packages instead of separate user packages (saves space)
    useGlobalPkgs = true;
    useUserPackages = true;
    # Pass unstable packages to home-manager modules
    extraSpecialArgs = {
      pkgs-unstable = pkgs-unstable;
    };
    # User-specific Home Manager configurations
    users.schulze.imports = [
      ./hm/home-manager.nix # Base user environment
      ./hm/hyprland.nix # Hyprland window manager user config
      ./hm/hyprlock.nix # Hyprlock screen lock user config
      ./hm/hypridle.nix # Hypridle idle daemon user config
      ./hm/cursor.nix # Mouse cursor config
      ./hm/rofi.nix # Rofi theme/config
      ./hm/ghostty.nix # Ghostty config
      ./hm/gtk.nix # GTK theme
      ./hm/nextcloud.nix # Nextcloud autostart
      ./hm/code-cursor.nix # Cursor config
      ./hm/vim.nix # Vim config
      ./hm/hyprsunset.nix # Hyprsunset night mode
      ./hm/btop.nix # Btop config
      ./hm/ssh.nix # SSH config
      ./hm/gitkraken.nix # GitKraken config
      ./hm/waybar.nix # Waybar config
      ./hm/cava.nix # Audio visualizer config
    ];
  };

  # ================================
  # USER MANAGEMENT
  # ================================
  users = {
    # Define the main user account
    users.schulze = {
      isNormalUser = true;
      description = "Felix Schulze";
      extraGroups = ["networkmanager" "wheel" "docker" "plugdev"];
      shell = pkgs.fish;
    };
    groups.libvirtd.members = ["schulze"];
  };

  # ================================
  # BOOT CONFIGURATION
  # ================================
  boot = {
    # Use systemd-boot (modern UEFI bootloader)
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Always use the latest kernel for best hardware support
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # ================================
  # NETWORKING
  # ================================
  networking = {
    # Enable NetworkManager for easy network configuration
    networkmanager.enable = true;

    # Security: Enable firewall and block all ports by default
    # Host-specific ports are opened in individual host configurations
    firewall.enable = true;
  };

  # ================================
  # LOCALIZATION
  # ================================
  # Set timezone to Swedish time
  time.timeZone = "Europe/Stockholm";

  # Internationalization: English UI with Swedish regional settings
  i18n = {
    defaultLocale = "en_GB.UTF-8"; # British English for UI
    extraLocaleSettings = {
      # Swedish locale for regional formats (dates, currency, etc.)
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

  # Configure console to use Swedish keyboard layout
  console.keyMap = "sv-latin1";

  # ================================
  # SYSTEM SERVICES
  # ================================
  services = {
    # Disable CUPS printing (enable per-host if needed)
    printing.enable = false;

    # Modern audio stack: PipeWire replaces PulseAudio
    pulseaudio.enable = false; # Disable old PulseAudio
    pipewire = {
      enable = true;
      alsa.enable = true; # ALSA compatibility
      alsa.support32Bit = true; # 32-bit app support
      pulse.enable = true; # PulseAudio compatibility
      wireplumber.enable = true; # Session manager
    };
    playerctld.enable = true; # Playerctl daemon for media controls

    # Antivirus protection with automatic updates
    clamav = {
      daemon.enable = true; # Background virus scanning
      updater.enable = true; # Automatic signature updates
    };

    # Enable GNOME keyring for password management
    gnome.gnome-keyring.enable = true;

    # Bluetooth support
    blueman.enable = true;
  };

  # Bluetooth support
  hardware.bluetooth.enable = true;

  # power management tool which allows for managing hibernate and suspend states
  powerManagement.enable = true;

  # ================================
  # PERMISSIONS
  # ================================
  # Enable real-time scheduling for audio applications (low-latency audio)
  security.rtkit.enable = true;
  # Enable Polkit for GUI authentication dialogs (password prompts)
  security.polkit.enable = true;

  # ================================
  # NIX CONFIGURATION
  # ================================
  # Allow installation of proprietary/unfree software
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"]; # Enable modern Nix features (flakes and new CLI)

    # Optimise the Nix store automatically to recover space
    optimise = {
      automatic = true;
      dates = ["03:45"];
      persistent = true; # Run missed optimisations
    };

    # Garbage collect the Nix store automatically to recover space
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
      persistent = true; # Run missed GC
    };
  };

  # ================================
  # AUTOMATIC MAINTENANCE
  # ================================
  # Configure automatic system updates for security
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath; # Use this flake for updates
    flags = [
      "--update-input"
      "nixpkgs" # Update nixpkgs input
      "-L" # Print build logs for transparency
    ];
    dates = "02:00"; # Run at 2 AM
    randomizedDelaySec = "45min"; # Random delay to avoid server load
  };

  # ================================
  # FONTS
  # ================================
  # System-wide fonts for consistent typography
  fonts.packages = with pkgs; [
    intel-one-mono # Monospace font for coding
    noto-fonts # Comprehensive Unicode support
    noto-fonts-cjk-sans # CJK support
    noto-fonts-emoji # Emoji support
    nerd-fonts.symbols-only # Symbols
    fira-code # Monospace font for coding
    fira-code-symbols # Symbols
  ];

  # ================================
  # ENVIRONMENT VARIABLES
  # ================================
  environment.sessionVariables = {
    # Improve touchscreen and scrolling support in Firefox
    MOZ_USE_XINPUT2 = "1";
    # Screenshot directory for Hyprshot
    HYPRSHOT_DIR = "$HOME/Nextcloud/Home-sync/Pictures/Screenshots";
  };

  # ================================
  # SECURITY HARDENING
  # ================================
  # Enable fail2ban for brute force protection
  services.fail2ban = {
    enable = true;
    # Ban IP after 3 failures
    maxretry = 3;
    bantime = "1h"; # Ban IPs for one hour on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  # Disable core dumps to prevent potential security exploits
  # and improve system performance during crashes
  systemd.coredump.enable = false;

  # SANDBOXED APPLICATIONS
  # Enable Firejail for application sandboxing (security)
  programs.firejail = {
    enable = true;
    # Create sandboxed wrappers for browsers
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        extraArgs = [
          # Required for U2F USB security keys
          "--ignore=private-dev"
          # Enable desktop notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      chromium = {
        executable = "${pkgs.lib.getBin pkgs.ungoogled-chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
      };
    };
  };
  environment.etc = {
    "firejail/firefox.local".text = ''
      # Custom Firejail profile for firefox
      # Allow access to downloads
      noblacklist ''${HOME}/Nextcloud
      whitelist ''${HOME}/Nextcloud

      # Enable native notifications.
      dbus-user.talk org.freedesktop.Notifications
      # Allow inhibiting screensavers.
      dbus-user.talk org.freedesktop.ScreenSaver
      # Allow screensharing under Wayland.
      dbus-user.talk org.freedesktop.portal.Desktop
    '';
  };

  # HARDWARE SECURITY (YUBIKEY)
  # Enable Yubikey support for SSH and GPG
  services.yubikey-agent.enable = true;
  # Enable U2F authentication for login
  security.pam.u2f.enable = true;
}
