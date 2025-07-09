{config, ...}: {
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/Nextcloud/Home-sync/Desktop";
    documents = "${config.home.homeDirectory}/Nextcloud/Home-sync/Documents";
    download = "${config.home.homeDirectory}/Nextcloud/Home-sync/Downloads";
    music = "${config.home.homeDirectory}/Nextcloud/Home-sync/Music";
    pictures = "${config.home.homeDirectory}/Nextcloud/Home-sync/Pictures";
    publicShare = "${config.home.homeDirectory}/Nextcloud/Home-sync/Public";
    templates = "${config.home.homeDirectory}/Nextcloud/Home-sync/Templates";
    videos = "${config.home.homeDirectory}/Nextcloud/Home-sync/Videos";
  };
  gtk.gtk3.bookmarks = [
    "file://${config.home.homeDirectory}/Nextcloud/Home-sync/Downloads"
    "file://${config.home.homeDirectory}/Nextcloud/Home-sync/Documents"
    "file://${config.home.homeDirectory}/Nextcloud/Home-sync/Pictures"
  ];
}
