{
  description = "Felix's NixOS configurations";

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    specials = {
      inherit inputs;
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      wildfire = nixpkgs.lib.nixosSystem {
        specialArgs = specials;
        modules = [
          ./hosts/wildfire/configuration.nix
        ];
      };
      hurricane = nixpkgs.lib.nixosSystem {
        specialArgs = specials;
        modules = [
          ./hosts/hurricane/configuration.nix
        ];
      };
    };
  };

  inputs = {
    # NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
