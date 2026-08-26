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
  # Disable x11 window composition to avoid race condition when using xwayland-satellite
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    })   
  ];

  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
}
