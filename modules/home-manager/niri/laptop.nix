{
  inputs,
  pkgs,
  lib,
  config,
  home,
  ...
}:
{
  home.file.".config/niri".source = ./hosts/laptop;
}
