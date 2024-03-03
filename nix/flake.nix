{
  description = "Top level NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Alacritty theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, disko, home-manager, alacritty-theme, nixpkgs-unstable, ... }@inputs: {
    overlays.unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        system = prev.system;
        config.allowUnfree = prev.config.allowUnfree;
      };
    };

    nixosConfigurations.itachi = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
      	./machines/itachi/hardware-configuration.nix
        ./machines/itachi/disko-config.nix
        # General
        ./configuration.nix
        # Home Manager
        ({ config, pkgs, ...}: {
          nixpkgs.overlays = [
            self.overlays.unstable
            alacritty-theme.overlays.default
          ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.elliott = import ./home/home.nix;
        }
      ];
    };
    nixosConfigurations.sasuke = nixpkgs.lib.nixosSystem {
      specialArgs = {
        meta = { hostname = "sasuke"; };
      };
      system = "x86_64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
      	./machines/sasuke/hardware-configuration.nix
        ./machines/sasuke/disko-config.nix
        ./machines/sasuke/hardware.nix
        # General
        ./configuration.nix
        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.elliott = import ./home/home.nix;
        }
      ];
    };
  };
}
