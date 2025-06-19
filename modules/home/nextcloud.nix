{lib, ...}: {
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  systemd.user.services.nextcloud-client = {
    Unit = {
      After = lib.mkForce "graphical-session.target";
    };
  };
}
