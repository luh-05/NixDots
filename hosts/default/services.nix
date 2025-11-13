{
  config,
  pkgs,
  cpaths,
  ...
}:
let
  bundle-path = "${cpaths.services}/bundles";
  bundles = [
    "vr"
  ];
  services = [
    "git/gvfs"
    "misc/tumbler"
    "wm/xserver"
    "misc/ratbagd"
    "misc/cloudflare-warp"
  ];
in
{
  imports =
    map (x: "${bundle-path}/${x}.nix") bundles ++ map (x: "${cpaths.services}/${x}.nix") services;
}
