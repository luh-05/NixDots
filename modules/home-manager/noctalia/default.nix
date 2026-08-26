{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  ...
}:
{
  programs.noctalia = {
    enable = true;
    settings = {
      bar.default = {
        enabled = true;
        auto_hide = false;
        smart_auto_hide = true;
        reserve_space = false;
      };
      dock = {
        enabled = true;
        smart_auto_hide = true;
        reserve_space = false;
      };
      backdrop = {
        enabled = true;
        blur_intensity = 0.7;
        tint_intensity = 0.25;
      };
    };
  };
}
