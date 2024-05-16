{ pkgs, ... }:
let
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "dreamsofcode-io";
      repo = "catppuccin-tmux";
      rev = "main";
      sha256 = "sha256-FJHM6LJkiAwxaLd5pnAoF3a7AE1ZqHWoCpUJE0ncCA8=";
    };
  };
  rose-pine = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "rose-pine";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "tmux";
      rev = "main";
      sha256 = "sha256-0ccJVQIIOpHdr3xMIBC1wbgsARCNpmN+xMYVO6eu/SI=";
    };
  };
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "master";
      sha256 = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
    };
  };

in
{
  enable = true;

  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  newSession = true;
  secureSocket = true;
  shell = "${pkgs.zsh}/bin/zsh";
  shortcut = "a";
  terminal = "screen-256color";

  plugins = with pkgs.tmuxPlugins; [
    rose-pine
    tokyo-night
    yank
    sensible
    vim-tmux-navigator
  ];

  extraConfig = ''
    # set-default colorset-option -ga terminal-overrides ",xterm-256color:Tc"
    set -as terminal-features ",xterm-256color:RGB"
    # set-option -sa terminal-overrides ",xterm*:Tc"
    set -g mouse on

    unbind C-b
    set -g prefix C-Space
    bind C-Space send-prefix

    # Vim style pane selection
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Start windows and panes at 1, not 0
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on

    # Use Alt-arrow keys without prefix key to switch panes
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # Shift arrow to switch windows
    bind -n S-Left  previous-window
    bind -n S-Right next-window

    # Shift Alt vim keys to switch windows
    bind -n M-H previous-window
    bind -n M-L next-window

    set -g @tokyo-night-tmux_window_id_style hsquare
    set -g @tokyo-night-tmux_show_datetime 0

    run-shell ${tokyo-night}/share/tmux-plugins/tokyo-night/tokyo-night.tmux

    # set vi-mode
    set-window-option -g mode-keys vi

    # keybindings
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"
  '';
}
