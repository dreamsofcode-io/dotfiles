# Edit this configuration file to define what should be installed onconfig
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, outputs, config, lib, pkgs, meta, ... }:

{
  imports = [
    ./modules/languages.nix
    ./modules/gnome.nix
    ./modules/gaming.nix
    ./modules/messaging.nix
    ./modules/yubikey-gpg.nix
    ./modules/unfree.nix
    ./modules/video.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.unstable

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = meta.hostname; # Hostname is defined by the flake.

  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    openmoji-color
  ];

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elliott = {
    isNormalUser = true;
    extraGroups = [
    "wheel" # Enable ‘sudo’ for the user.
    "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNFZUZg93LySz/1Qdg7WBEBdpnSMjJyJmFwnPikmTHJ/MQWC0Bf5kVyfkLxaU3paeRQnoI4RcG9k8DJGy8hnUdxe2Eg5fWtW0+cJ0zm791WisCTb8bCmTBO9053U59qOA7WTrJAVcTylBsBa7R3CGs6FYlMsu8CXvUWrp4XQ2k83DQlzpgr5r9BNIsfbfswXMSm91i/bRSuxSXu2QpV/9C4wHBUYAGz+hTFw8LJgt/lH6ute2w1ed93/vG4CNI9gv1obecc8rrVGvjZk1Q6sPr8PamBxc7Y4HEYWKPtJPq54UK+b2duUuL2tDYVQmJIvto6how+EZ/oAPxMRK5qHJOn2AJ/z0rcPO6FqyggtKeZATOgFCYSNLLrEwiYvppVNiM/hjFRqpk+BZ+gWE1X+D3xXIDUG1jchMCUQ/2q62CSp/VU/z39IGBxa9eN/k6WsmdlKgeCcx2BtoFKMd0LQqfndduYPcnvn2EzJwLrF0p7LQGIO74jkAQ451IeSoDOvlCe9Y9LAjwH1DG4ve7XwuqpKdJ2LcHirLHxQIONdc906U70TVuQzGOJed5huhKBkbGzDi08VsF8zCO9pMHSJ2ioBWVyNSRUf9wVKtPtUFhmgCHT/l0+xdrCeE8m7sT0Zb8qNjdMDylXQhaPm30f/ievIBe5+81w0Kyoj4kFSzr3Q== cardno:11_070_772"
    ];
  };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    calibre
    firefox
    chromium
    erlang
    rebar3
    interception-tools
    git
    gleam
    kubectl
    fzf
    lua-language-server
    jq
    neovim
    pika-backup
    ripgrep
    protonvpn-cli
    tmux
    wl-clipboard
    stow
    glib
    gtk3
    gio-sharp
    mm-common
    pkg-config
    stylua
    unzip
    transmission_4-gtk
    qemu
    templ
    gopls
    go-migrate
    eza
    gptscript
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    wofi
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # gnome
  services.xserver.enable = true; services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable interception tools. Possibly only needed for
  # laptop computers.
  services.interception-tools = {
    enable = true;
    plugins = with pkgs; [
      interception-tools-plugins.caps2esc
    ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
