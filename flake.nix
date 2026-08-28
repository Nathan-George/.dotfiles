{
  description = "Nathan's Nix Configuration";

  inputs = {
    # nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # hardware specific configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  }: let
    overlays = (import ./overlays);

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
          ./home/home.nix
        ];
	extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
