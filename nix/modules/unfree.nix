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
      "slack"
    ];

  environment.systemPackages = with pkgs; [
    davinci-resolve
    discord
    obsidian
    signal-desktop
    slack
  ];
}
