{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:
let
  # r8125 = pkgs.callPackage ./drivers/r8125.nix { kernel = config.boot.kernelPackages.kernel; };
in
{
  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_testing;
  #boot.extraModulePackages = [ r8125 ];
  # boot.blacklistedKernelModules = [ "r8169" ];
}
