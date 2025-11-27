{
  # Home Manager Hyprland monitors
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-3, 3440x1440@99.98, 0x0, 1, cm, auto" # Philips Ultrawide left
      "HDMI-A-1, 3440x1440@99.98, 3440x0, 1, cm, auto" # Philips Ultrawide right

      "eDP-1, 1920x1200@60.00, 6880x240, 1" # internal display
    ];
    bindl = [
      ",switch:off:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, 1920x1200@60.00, 6880x240, 1'" # enable display in hyprland when lid open
      ",switch:on:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'" # disable display in hyprland when lid closed
    ];
  };
}
