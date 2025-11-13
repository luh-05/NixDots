{
  inputs,
  config,
  options,
  lib,
  ...
}:
let

in
{
  services.xserver.enable = lib.mkDefault false;
  services.xserver.displayManager.lightdm.enable = false;
}
