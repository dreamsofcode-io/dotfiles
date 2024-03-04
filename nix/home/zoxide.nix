{ pkgs, ... }:
{
  enable = true;
  enableZshIntegration = true;
  options = ["--cmd cd"];
}
