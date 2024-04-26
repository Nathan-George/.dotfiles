{
  description = "My Flake";
  
  inputs = {
    # nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hardware specific configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
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
          ./user/home.nix
        ];
      };
    };

  };
  
}
 
