{ config, pkgs, ... }:
let
  service-path = "../../services";
  services = [
    "vr/monado"
  ];
in
{
  include = map (x: "${service-path}/${x}.nix") services;
}
