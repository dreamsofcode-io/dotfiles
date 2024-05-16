{config, pkgs, ...}:
{
  enable = true;
  settings = ''
    bind = $mainMod, Q, exec, alacritty
  ''
}
