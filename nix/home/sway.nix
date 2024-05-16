{ config, pkgs, ... }:
{
  enable = true;
  config = rec {
    modifier = "Mod4";
    terminal = "alacritty";
    startup = [
      # Launch Firefox on start
      {command = "firefox";}
    ];
  };
}
