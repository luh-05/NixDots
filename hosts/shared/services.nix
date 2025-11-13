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
    "misc/dbus"
    "audio/pipewire"
    "misc/printing"
  ];
in
{
  imports =
    map (x: "${bundle-path}/${x}.nix") bundles ++ map (x: "${cpaths.services}/${x}.nix") services;
}
