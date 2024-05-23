{ pkgs, ... }:
{
  enable = true;
  enableZshIntegration = true;
  enableFishIntegration = true;
  options = ["--cmd cd"];
}
