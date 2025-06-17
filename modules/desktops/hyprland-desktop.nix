{
  inputs,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = false;
    };
    # Greetd is lightweight and Wayland-native
    greetd.enable = true;

    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      # Only enable the flake packages after Cachix has already been enabled
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    regreet.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface" = {
            gtk-theme = "Gruvbox-Dark-B";
            icon-theme = "Flat-Remix-Red-Dark";
            font-name = "Noto Sans Medium 11";
            document-font-name = "Noto Sans Medium 11";
            monospace-font-name = "Intel One Mono Medium 11";
          };
        }
      ];
    };
  };

  xdg = {
    mime.defaultApplications = {
      "default-web-browser" = ["firefox.desktop"];
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };

  environment.sessionVariables = {
    BROWSER = "${pkgs.lib.getBin pkgs.firefox}";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # Core Hyprland workflow tools
    waybar # Panel
    rofi-wayland # Launcher
    mako # Notification daemon
    hyprpaper # Wallpaper daemon
    hyprlock # Lock screen
    wl-clipboard # Clipboard utils
    cliphist # Clipboard manager
    pavucontrol # GUI audio mixer
    blueman # Bluetooth tray
    networkmanagerapplet # System tray for network
    brightnessctl # Brightness (for laptops)
    wlsunset # Night light/gamma adjustment
    grim
    slurp
    swappy
    wf-recorder # Screenshots & screenrecording
    libsForQt5.qt5ct # For QT application appearance
    nautilus # File manager
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
  services.gnome.sushi.enable = true;
}
