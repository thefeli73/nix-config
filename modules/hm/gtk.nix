{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Blue-Dark-Gruvbox";
      package = pkgs.colloid-gtk-theme.override {
        colorVariants = ["dark"];
        themeVariants = ["default"]; # Blue
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
  };
  # ================================
  # GTK THEMING CONFIGURATION
  # ================================
  # dconf: Configure GTK applications and GNOME settings
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Colloid-Blue-Dark-Gruvbox";
        color-scheme = "prefer-dark";
      };
    };
  };
}
