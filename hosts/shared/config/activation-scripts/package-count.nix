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
      echo ${toString (builtins.length config.environment.systemPackages)} \
        > /etc/package-count
    '';
    deps = [];
  };
}
