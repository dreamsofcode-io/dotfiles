{ inputs, config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  imports = [
    ./ags/default.nix
  ];

  programs.home-manager.enable = true;

  home.username = "elliott";
  home.homeDirectory = "/home/elliott";
  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/elliott/.dotfiles/.config/nvim";
  xdg.dataFile.password-store.source = mkOutOfStoreSymlink "/home/elliott/.password-store";

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "23.11";

  programs = {
    tmux = (import ./tmux.nix { inherit pkgs; });
    zsh = (import ./zsh.nix { inherit config pkgs; });
    neovim = (import ./neovim.nix { inherit config pkgs; });
    git = (import ./git.nix { inherit config pkgs; });
    alacritty = (import ./alacritty.nix { inherit config pkgs; });
    gpg = (import ./gpg.nix { inherit config pkgs; });
    firefox = (import ./firefox.nix { inherit pkgs; });
    zoxide = (import ./zoxide.nix { inherit pkgs; });
    password-store = (import ./pass.nix { inherit pkgs; });
    fzf = (import ./fzf.nix { inherit pkgs; });
  };

  # gtk = {
  #   enable = true;
    # gtk3.extraConfig.gtk-decoration-layout = "menu:";
    # theme = {
    #   name = "Tokyonight-Dark-B";
    #   package = pkgs.tokyo-night-gtk;
    # };
    # iconTheme = {
    #   name = "Tokyonight-Dark";
    # };
  #   # cursorTheme = {
  #   #   name = gtkCursorTheme;
  #   #   package = pkgs.bibata-cursors;
  #   # };
  # };

  wayland.windowManager = {
    hyprland = (import ./hyprland.nix { inherit pkgs; });
  };
}
