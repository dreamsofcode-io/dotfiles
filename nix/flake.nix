{
  description = "Top level NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.itachi = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./itachi/configuration.nix
      ];
    };
  };
}
