{
  description = "My Flake";
  
  inputs = {
    # nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # hardware specific configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, plasma-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {

    # nixos configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          nixos-hardware.nixosModules.framework-11th-gen-intel
        ];
      };
    };

    # home manager configuration
    homeConfigurations = {
      jayden = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./home/home.nix
        ];
      };
    };

  };
}
