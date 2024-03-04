{ pkgs, ... }:
{
  enable = true;
  package = pkgs.firefox.override {
    cfg = {
      # Gnome shell native connector
      enableGnomeExtensions = true;
      # Tridactyl native connector
      enableTridactylNative = true;
    };
  };
}
