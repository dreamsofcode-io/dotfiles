{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    elixir
    gcc
    go
    nodejs
    rustup
  ];
}
