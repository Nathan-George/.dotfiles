{
  description = "My Flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hardware specific configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    # color manager
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, nix-colors, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {

    # nixos configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.framework-11th-gen-intel
        ];
      };
    };

    # home manager configuration
    homeConfigurations = {
      jayden = home-manager.lib.homeManagerConfiguration {
        # extraSpecialArgs = { inherit nix-colors; };
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };

  };
  
}
 
