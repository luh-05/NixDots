{
  inputs,
  config,
  options,
  ...
}:
let

in
{
  virtualisation.podman = {
    enable = true;
  };
  networking.nftables.enable = true;
}
