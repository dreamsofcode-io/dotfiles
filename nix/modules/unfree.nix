{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "discord"
      "signal-desktop"
      "steam"
      "steam-run"
      "steam-original"
      "obsidian"
    ];

  environment.systemPackages = with pkgs; [
    discord
    obsidian
    signal-desktop
  ];
}
