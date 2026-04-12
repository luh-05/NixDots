{
  config,
  lib,
  pkgs,
  options,
  inputs,
  hostName,
  ...
}:
{
  system.activationScripts.packageCount = {
    text = ''
      echo ${hostName} \
        > /etc/nixos-hostname
    '';
    deps = [];
  };
}
