{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  ...
}:
{
  home.packages = with pkgs; [
    niri
    xwayland-satellite
  ];
  home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${cpaths.modules.home}/niri/hosts/${hostName}/"; 
}
