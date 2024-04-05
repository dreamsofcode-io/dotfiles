{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome.networkmanager-openvpn
    gnome.gnome-shell-extensions
    gnomeExtensions.tiling-assistant
    gnomeExtensions.window-calls
    gnome.zenity
  ];
}
