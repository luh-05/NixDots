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
  services.xserver.enable = lib.mkDefault true;
  services.xserver.displayManager.lightdm.enable = true;
}
