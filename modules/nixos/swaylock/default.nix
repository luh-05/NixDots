{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  security,
  ...
}:
{
  home-manager.users.luh.programs.swaylock = {
    enable = true;
    settings = {
      indicator-line-visible = true;
      indicator-radius = 100;
      
      show-failed-attempts = true;
    };
  };
  security.pam.services.swaylock = {};
}
