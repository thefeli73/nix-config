{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      # Only enable GDM if you want login screen; alternatively, use greetd (recommended)
      displayManager.gdm.enable = false;
    };

    # Greetd is lightweight and Wayland-native
    greetd = {
      enable = true;
      settings.default_session = {
        user = "schulze";
        command = "$SHELL -l";
      };
    };

    # Power management (battery status, etc)
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  # Hyprland is your new desktop
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.regreet.enable = true;
  programs.dconf = {
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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment.sessionVariables = {
    GTK_THEME = "Gruvbox-Dark-B"; # or whatever your installed variant is called
    QT_QPA_PLATFORMTHEME = "qt5ct";
    NIXOS_OZONE_WL = "1";
    # XCURSOR_THEME = "Gruvbox-Dark";    # (Optional)
  };

  environment.systemPackages = with pkgs; [
    # Core Hyprland workflow tools
    waybar # Panel
    nwg-look # GTK theme tweaker
    rofi-wayland # Launcher (or fuzzel/wofi/tofi)
    mako # Notification daemon
    hyprpaper # Wallpaper daemon (native)
    hyprlock # Lock screen (native)
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
    # Install the Gruvbox GTK theme (many are packaged, else use overlays)
    gruvbox-gtk-theme
    # Gruvbox icons/cursors if desired
    gruvbox-dark-icons-gtk
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
  services.gnome.sushi.enable = true;
}
