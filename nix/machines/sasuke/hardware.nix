{ config, lib, pkgs, meta, ... }:
{
  hardware.system76.kernel-modules.enable = true;
  hardware.system76.enableAll = true;
}
