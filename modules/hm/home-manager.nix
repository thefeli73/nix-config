{pkgs, ...}: {
  home = {
    stateVersion = "25.05"; # Dont change
    file.".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/libexec/docker/cli-plugins/docker-buildx";
  };
}
