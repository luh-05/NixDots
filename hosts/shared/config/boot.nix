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
  boot.kernelModules = [
    "nf_nat_ftp"
    "v4l2loopback'"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=1,2 card_label="OBS Cam, Virt Cam" exclusive_caps=1
  '';
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
