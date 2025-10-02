# Hyprland Desktop Environment Configuration
# Complete setup for Hyprland Wayland compositor with modern desktop tools
{
  inputs,
  pkgs,
  ...
}: {
  # ================================
  # DISPLAY SERVER CONFIGURATION
  # ================================
  services = {
    # X11 server configuration (for compatibility)
    xserver = {
      enable = true;
      displayManager.gdm.enable = false; # Disable GDM in favor of regreet
      excludePackages = [pkgs.xterm]; # Exclude xterm from the list of packages to install
    };

    # Lightweight Wayland-native display manager
    greetd.enable = true;

    # Power management services for laptops and desktops
    upower.enable = true; # Battery and power device monitoring
    power-profiles-daemon.enable = true; # CPU frequency scaling

    # Hypridle, idle daemon
    hypridle.enable = true;
  };

  # ================================
  # HYPRLAND BINARY CACHE
  # ================================
  # Configure Cachix for faster Hyprland installations
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # ================================
  # HYPRLAND & SESSION MANAGEMENT
  # ================================
  programs = {
    # Main Hyprland configuration
    hyprland = {
      enable = true;
      withUWSM = true; # Enable Universal Wayland Session Manager
      # Use cutting-edge Hyprland from flake input (latest features)
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # regreet: Modern, customizable greeter for greetd
    regreet = {
      enable = true;
      theme = {
        name = "Colloid-Green-Dark-Gruvbox";
        package = pkgs.colloid-gtk-theme.override {
          colorVariants = ["dark"];
          themeVariants = ["green"];
          tweaks = [
            "gruvbox"
            "rimless"
            "float"
          ];
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override {color = "black";};
      };
      cursorTheme = {
        name = "capitaine-cursors";
        package = pkgs.capitaine-cursors;
      };
    };

    # UWSM: Universal Wayland Session Manager
    uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };

    # Waybar status bar & panel
    waybar.enable = true;
  };

  # ================================
  # XDG & DESKTOP INTEGRATION
  # ================================
  xdg = {
    # Set default applications for file types
    mime = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "x-scheme-handler/ftp" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    # XDG Desktop Portal for Wayland integration
    portal = {
      enable = true;
      xdgOpenUsePortal = true; # Use portal for opening files/URLs
    };
  };

  # ================================
  # ENVIRONMENT VARIABLES
  # ================================
  # global variables set on shell initialization
  environment.variables = {
  };
  # session variables
  environment.sessionVariables = {
    # Set Firefox as default browser
    BROWSER = "${pkgs.lib.getBin pkgs.firefox}";
    # Enable Wayland support for Electron apps (VS Code, Discord, etc.)
    NIXOS_OZONE_WL = "1";
  };

  # ================================
  # HYPRLAND DESKTOP PACKAGES
  # ================================
  # Essential tools for a functional Hyprland desktop
  environment.systemPackages = with pkgs; [
    # ---- CORE HYPRLAND WORKFLOW ----
    rofi # Application launcher and dmenu replacement (rofi has native wayland support)
    mako # Notification daemon
    hyprlock # Screen lock utility
    hyprpicker # Color picker
    waybar-mpris # MPRIS support for waybar

    # ---- CLIPBOARD & INPUT ----
    wl-clipboard # Clipboard utilities for Wayland
    cliphist # Clipboard history manager

    # ---- SYSTEM CONTROL ----
    pavucontrol # GUI audio mixer and control
    networkmanagerapplet # Network management system tray
    brightnessctl # Screen brightness control (laptops)

    # ---- SCREENSHOT & RECORDING ----
    grim # Screenshot tool for Wayland
    slurp # Screen area selection for screenshots
    hyprshot # Screenshot tool for Hyprland
    swappy # Screenshot editing and annotation
    wf-recorder # Screen recording for Wayland

    # ---- APPLICATION INTEGRATION ----
    libsForQt5.qt5ct # Qt5 application theming control
    nautilus # GNOME file manager (GTK)
  ];

  # ================================
  # FILE MANAGER INTEGRATION
  # ================================
  # Configure Nautilus to work seamlessly with the desktop
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty"; # Use Ghostty as default terminal in file manager
  };

  # Enable GNOME Sushi for file preview in Nautilus
  services.gnome.sushi.enable = true;
}
