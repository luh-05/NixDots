{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:
let
  r8125 = pkgs.callPackage ./drivers/r8125.nix { kernel = config.boot.kernelPackages.kernel; };
in
{
  # boot.kernelParams = [
  #   "video=card1-DP-2:d"
  #   "video=card1-DP-3:d"
  #   "video=card1-DP-4:3440x1440"
  #   "video=card2-DP-2:d"
  #   "video=card2-DP-3:d"
  #   "video=card2-DP-4:3440x1440@164."
  # ];
  boot.plymouth.enable = false;
  #boot.extraModulePackages = [ r8125 ];
  boot.blacklistedKernelModules = [ "r8169" ];
}
