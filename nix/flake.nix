{
  description = "Top level NixOS Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Unstable Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Alacritty theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    # Templ
    templ.url = "github:a-h/templ";

    # Ags
    ags.url = "github:Aylur/ags";

    # Matugen
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
  };

  outputs = { self, nixpkgs, disko, home-manager, alacritty-theme, templ, nixpkgs-unstable, ags, ... }@inputs: let
    inherit (self) outputs;

    systems = [
      "x86_64-linux"
    ];

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };
    };

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in  {

    overlays.additions = final: _prev: import ./pkgs final.pkgs;

    overlays.unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        system = prev.system;
        config.allowUnfree = prev.config.allowUnfree;
      };
    };

    nixpkgs.overlays = [
      self.overlays.unstable
      alacritty-theme.overlays.default
      templ.overlays.default
    ];

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosConfigurations.itachi = nixpkgs.lib.nixosSystem {
      specialArgs = {
        meta = { hostname = "itachi"; };
      };
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
            inputs.templ.overlays.default
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
    nixosConfigurations.amaterasu = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
        meta = { hostname = "amaterasu"; };
      };
      system = "x86_64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
      	./machines/amaterasu/hardware-configuration.nix
        ./machines/amaterasu/disko-config.nix
        # General
        ./configuration.nix
        # Home Manager
        ({ config, pkgs, ...}: {
          nixpkgs.overlays = [
            self.overlays.unstable
            self.overlays.additions
            alacritty-theme.overlays.default
            inputs.templ.overlays.default
          ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.elliott = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
    nixosConfigurations.karasu = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
        meta = { hostname = "karasu"; };
      };
      system = "x86_64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
      	./machines/karasu/hardware-configuration.nix
        ./machines/karasu/disko-config.nix
        # General
        ./configuration.nix
        # Home Manager
        ({ config, pkgs, ...}: {
          nixpkgs.overlays = [
            self.overlays.unstable
            self.overlays.additions
            alacritty-theme.overlays.default
            inputs.templ.overlays.default
          ];
        })
        home-manager.nixosModules.home-manager
        {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.elliott = import ./home/home.nix;
           home-manager.extraSpecialArgs = {inherit inputs; };
        }
      ];
    };
    nixosConfigurations.kitsune = nixpkgs.lib.nixosSystem {
      specialArgs = {
        meta = { hostname = "kitsune"; };
      };
      system = "x86_64-linux";
      modules = [
        # Modules
        disko.nixosModules.disko
      	# System Specific
      	./machines/kitsune/hardware-configuration.nix
        ./machines/kitsune/disko-config.nix
        # General
        ./configuration.nix
        # Home Manager
        # Home Manager
        ({ config, pkgs, ...}: {
          nixpkgs.overlays = [
            self.overlays.unstable
            alacritty-theme.overlays.default
            inputs.templ.overlays.default
            inputs.ags.overlays.default
          ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.elliott = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
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

    homeConfigurations.elliott = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };

      modules = [
	      ./home.nix
      ];
    };
  };
}
