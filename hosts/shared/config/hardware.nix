{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:

let
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
