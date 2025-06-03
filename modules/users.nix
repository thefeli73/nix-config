{
  config,
  pkgs,
  ...
}: {
  # Define the main user account
  users = {
    users.schulze = {
      isNormalUser = true;
      description = "Felix Schulze";
      extraGroups = ["networkmanager" "wheel" "docker"];
      shell = pkgs.fish;
    };
    groups.libvirtd.members = ["schulze"];
  };
}
