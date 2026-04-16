{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  security,
  ...
}:
{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
}
