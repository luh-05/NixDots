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
  xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "./${hostName}"; 
}
