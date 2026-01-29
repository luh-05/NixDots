{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:

let
  ldlp = [
    "${pkgs.wayland}/lib:$LD_LIBRARY_PATH"
    "${config.services.pipewire.package.jack}/lib"
    "$LD_LIBRARY_PATH"
  ];
in
{
  # wayland fixes
  environment.sessionVariables = {
    LD_LIBRARY_PATH = lib.mkForce (lib.concatStringsSep ":" ldlp);
  };
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # other
  environment.variables.EDITOR = "hx";
}
