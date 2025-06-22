{pkgs, ...}: {
  services.xserver = {
    # Enable the X11 windowing system (needed even for Wayland sessions)
    enable = true;

    # Exclude xterm from the list of packages to install
    excludePackages = [pkgs.xterm];

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "se";
      variant = "";
    };
  };
}
