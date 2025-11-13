{
  cpaths,
  ...
}:
let
  vr-path = "${cpaths.services}/vr";
  services = [
    "monado"
    "wivrn"
  ];
in
{
  imports = map (x: "${vr-path}/${x}.nix") services;
}
