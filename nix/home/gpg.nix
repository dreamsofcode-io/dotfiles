{ config, pkgs, ... }:
{
  enable = true;

  publicKeys = [
    { source = ../../keys/gpg-0x80015B87EFAB63A4-2021-10-18.asc; }
    { source = ../../keys/gpg-0x80015B87EFAB63A4-2022-12-16.asc; }
  ];
}
