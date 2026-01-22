# Hyprland Desktop Environment Configuration
# Complete setup for Hyprland Wayland compositor with modern desktop tools
{
  inputs,
  pkgs,
  ...
}: let
  hyprshot-sdr = pkgs.writeShellScriptBin "hyprshot-sdr" ''
    set -euo pipefail

    # Wrapper around hyprshot that temporarily disables HDR/wide-gamut capture.
    # In Hyprland HDR mode, grim/hyprshot screenshots look oversaturated in SDR apps.
    # This script:
    # - Detects monitors with "colorManagementPreset": "hdr"
    # - Temporarily switches those monitors to SDR (drops HDR-related tokens)
    # - Runs hyprshot with the original arguments (keeps clipboard behavior)
    # - Restores the original monitor strings afterwards

    hyprctl_bin="${pkgs.hyprland}/bin/hyprctl"
    jq_bin="${pkgs.jq}/bin/jq"
    hyprshot_bin="${pkgs.hyprshot}/bin/hyprshot"

    monitors_json="$($hyprctl_bin monitors -j)"

    # Gather HDR monitors and build restore/sdr commands.
    mapfile -t hdr_monitors < <(printf '%s' "$monitors_json" | $jq_bin -r '.[] | select(.colorManagementPreset == "hdr") | .name')

    restore_batch=""
    sdr_batch=""

    for name in "''${hdr_monitors[@]}"; do
      # This matches the user-provided monitor string format in this repo:
      # "DP-1, 2560x1440@210.00, 0x0, 1, vrr, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.2"
      restore_line=$(printf '%s' "$monitors_json" | $jq_bin -r --arg name "$name" '.[] | select(.name==$name) |
        "\(.name), \(.width)x\(.height)@\(.refreshRate), \(.x)x\(.y), \(.scale), vrr, \(.vrr | if . then 1 else 0 end), bitdepth, \(
          if (.currentFormat | test("2101010")) then 10 else 8 end
        ), cm, hdr, sdrbrightness, \(.sdrBrightness)"')

      # SDR line: same base fields, omit HDR tokens. (Hyprland default is SDR/8-bit.)
      sdr_line=$(printf '%s' "$monitors_json" | $jq_bin -r --arg name "$name" '.[] | select(.name==$name) | "\(.name), \(.width)x\(.height)@\(.refreshRate), \(.x)x\(.y), \(.scale), vrr, \(.vrr | if . then 1 else 0 end)"')

      restore_batch+="keyword monitor ''${restore_line}; "
      sdr_batch+="keyword monitor ''${sdr_line}; "
    done

    restore() {
      if [[ -n "$restore_batch" ]]; then
        $hyprctl_bin --batch "$restore_batch" >/dev/null
      fi
    }

    # Don't use `exec` here: it would replace this process with `hyprshot`
    # and skip running the EXIT trap, leaving monitors stuck in SDR.
    trap restore EXIT INT TERM

    if [[ -n "$sdr_batch" ]]; then
      $hyprctl_bin --batch "$sdr_batch" >/dev/null
      # Small delay to let outputs reconfigure.
      sleep 0.2
    fi

    $hyprshot_bin "$@"
  '';
in {
  # ================================
  # DISPLAY SERVER CONFIGURATION
  # ================================
  services = {
    # X11 server configuration (for compatibility)
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm]; # Exclude xterm from the list of packages to install
    };
    displayManager.gdm.enable = false; # Disable GDM in favor of regreet

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
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
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
    HYPRSHOT_DIR = "$HOME/Nextcloud/Home-sync/Pictures/Screenshots";
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
    hyprshot-sdr # HDR-safe hyprshot wrapper (toggle SDR for capture)
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
