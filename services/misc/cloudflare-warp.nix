{
  inputs,
  config,
  options,
  ...
}:
let

in
{
  services.cloudflare-warp.enable = true;
}
