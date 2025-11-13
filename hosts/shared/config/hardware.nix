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
  # wayland fixes
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.wayland}/lib:$LD_LIBRARY_PATH";
  };
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
