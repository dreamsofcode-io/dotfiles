{ pkgs, ... }:
{
  enable = true;
  package = pkgs.firefox.override {
    cfg = {
      # Gnome shell native connector
      enableGnomeExtensions = true;
    };
  };
}
