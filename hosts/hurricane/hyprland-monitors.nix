{
  # Home Manager Hyprland monitors
  wayland.windowManager.hyprland.extraConfig = ''
    monitor = DP-3, 3440x1440@99.98, 0x0, auto; # Philips Ultrawide left
    monitor = HDMI-A-1, 3440x1440@99.98, 3440x0, auto; # Philips Ultrawide right
    monitor = eDP-1, 1920x1200@60.00, auto, auto # internal display
  '';
}
