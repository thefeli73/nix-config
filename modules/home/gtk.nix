{pkgs, ...}: {
  home.packages = with pkgs; [
    dconf
    gruvbox-dark-gtk
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-B";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # ================================
  # GTK THEMING CONFIGURATION
  # ================================
  # dconf: Configure GTK applications and GNOME settings
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Gruvbox-Dark-B";

        color-scheme = "prefer-dark";
      };
    };
  };
}
