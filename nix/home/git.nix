{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "Elliott Minns";
  userEmail = "elliott.minns@pm.me";
  signing.key = null;
  signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
