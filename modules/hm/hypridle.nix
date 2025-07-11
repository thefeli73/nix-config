{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 300; # 5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }
        {
          timeout = 900; # 15min.
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        # no automatic screen off or sleep. causes issues i cant be arsed to fix. use `systemctl suspend` instead.
      ];
    };
  };
}
