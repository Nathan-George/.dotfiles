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

    # hardware specific configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # nix colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-hardware,
    plasma-manager,
    nix-colors,
    ...
  }: let
    overlays = import ./overlays;

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system overlays; };
  in {
    # formatter
    formatter.${system} = pkgs.alejandra;

    # nixos configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-hardware.nixosModules.framework-13th-gen-intel
          ./system/configuration.nix
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
          ./home/profiles/nathan.nix
        ];
        extraSpecialArgs = {
          inherit nix-colors;
          inherit inputs;
        };
      };
    };
  };
}
