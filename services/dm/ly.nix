{
  inputs,
  config,
  options,
  lib,
  pkgs,
  ...
}:
{
  services.displayManager.sessionPackages = [ pkgs.niri ];
  
  services.displayManager.ly = {
    enable = true;
  };
}
