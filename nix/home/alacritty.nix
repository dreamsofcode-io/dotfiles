{ config, pkgs, ... }:
{
  enable = true;
  package = pkgs.unstable.alacritty;

  settings = {
    window = {
      padding = { x = 4; y = 8; };
      decorations = "full";
      opacity = 1;
      startup_mode = "Windowed";
      title = "Alacritty";
      dynamic_title = true;
      decorations_theme_variant = "None";
    };

    import = [
      pkgs.alacritty-theme.rose-pine
    ];

    font = let jetbrainsMono = style: {
      family = "JetBrainsMono Nerd Font";
      inherit style;
    }; in {
      size = 16;
      normal = jetbrainsMono "Regular";
      bold = jetbrainsMono "Bold";
      italic = jetbrainsMono "Italic";
      bold_italic = jetbrainsMono "Bold Italic";
    };

    cursor = {
      style = "Block";
    };

    env = {
      TERM = "xterm-256color";
    };

    live_config_reload = true;
  };
}
