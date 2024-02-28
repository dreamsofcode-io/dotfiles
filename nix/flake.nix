{
  description = "Top level NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    nixosConfigurations.itachi = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      	./itachi/hardware-configuration.nix
        ./configuration.nix
        disko.nixosModules.disko
	./itachi/disko-config.nix
      ];
    };
  };
}
