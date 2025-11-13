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
  services.xserver.libinput.enable = true;
}
