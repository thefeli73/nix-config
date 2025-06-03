{
  description = "Felix's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      wildfire = nixpkgs.lib.nixosSystem {
        specialArgs = { inputs = self.inputs; };
        modules = [ ./hosts/wildfire/configuration.nix ];
      };
    };
  };
}
