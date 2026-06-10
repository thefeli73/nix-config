{pkgs, ...}: {
  home = {
    stateVersion = "25.05"; # Dont change
    file.".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/libexec/docker/cli-plugins/docker-buildx";
  };

  programs.fish.enable = true;

  xdg.configFile."autostart/remmina-applet.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=Remmina Applet
    Comment=Connect to remote desktops through the applet menu
    Icon=org.remmina.Remmina
    Exec=remmina -i
    Terminal=false
    Type=Application
    Hidden=true
  '';
}
