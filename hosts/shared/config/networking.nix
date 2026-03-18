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
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.networkmanager.dns = "systemd-resolved";
  #networking.interfaces.enp14s0u1.mtu = 1400;
}
