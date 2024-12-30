{
  description = "Nathan's Nix Configuration";

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
    # nix colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    plasma-manager,
    nix-colors,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # nixos configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          nixos-hardware.nixosModules.framework-13th-gen-intel
        ];
      };
    };

    # home manager configuration
    homeConfigurations = {
      nathan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./home/home.nix
          ./home/modules
        ];
        extraSpecialArgs = {
          inherit nix-colors;
        };
      };
    };
  };
}
