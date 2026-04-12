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
  # programs.waybar = {
  #   enable = true;
  # };
  home.packages = with pkgs; [
    waybar
  ];

  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${cpaths.modules.home}/waybar/hosts/${hostName}/"; 
}
