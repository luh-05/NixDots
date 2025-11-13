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
    "misc/scx"
  ];
in
{
  imports =
    map (x: "${bundle-path}/${x}.nix") bundles ++ map (x: "${cpaths.services}/${x}.nix") services;
}
