{
  pkgs,
  randomHyprlock,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session"; # lock before suspend.
        lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${randomHyprlock}/bin/random-hyprlock";
      };

      listener = [
        {
          timeout = 300; # 5min.
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r"; # monitor backlight restore.
        }
        {
          timeout = 900; # 15min.
          on-timeout = "${pkgs.systemd}/bin/loginctl lock-session"; # lock screen when timeout has passed
        }
        # no automatic screen off or sleep. causes issues i cant be arsed to fix. use `systemctl suspend` instead.
      ];
    };
  };
}
