{
  inputs,
  config,
  options,
  ...
}:
let

in
{
  virtualisation.incus = {
    enable = true;
  };
  networking.nftables.enable = true;
}
