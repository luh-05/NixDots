{
  inputs,
  pkgs,
  lib,
  config,
  xdg,
  hostName,
  ...
}:
{
  programs.niri = {
    enable = true;
  };
  xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "./${hostName}"; 
}
