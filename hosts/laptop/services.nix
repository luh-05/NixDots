{
  config,
  pkgs,
  cpaths,
  ...
}:
let
  bundle-path = "${cpaths.services}/bundles";
  bundles = [
  ];
  services = [
    "git/gvfs"
    "misc/tumbler"
    "wm/xserver"
    "misc/ratbagd"
  ];
in
{
  imports =
    map (x: "${bundle-path}/${x}.nix") bundles ++ map (x: "${cpaths.services}/${x}.nix") services;
}
