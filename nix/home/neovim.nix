{ config, pkgs, ... }:
{
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
}
