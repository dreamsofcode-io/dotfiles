{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) (
      map lib.getName [
        pkgs.davinci-resolve
        pkgs.discord
        pkgs.unstable.keymapp
        pkgs.signal-desktop
        pkgs.steam
        pkgs.steam-run
        pkgs.steam-original
        pkgs.obsidian
        pkgs.slack
      ]
    );

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    davinci-resolve
    discord
    unstable.keymapp
    obsidian
    signal-desktop
    slack
  ];
}
