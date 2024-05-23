{ pkgs, ... }:
{
  enable = true;
  enableZshIntegration = true;
  enableFishIntegration = true;
  settings = {
    format = ''
    $directory
    $character
    '';
    add_newline = true;
    package = {
      disabled = true;
    };
  };
}
