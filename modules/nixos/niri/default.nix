{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  home-manager,
  ...
}:

{
  services.displayManager.sessionPackages = [ pkgs.niri ];
  
  home-manager.users.luh = {
    home.packages = with pkgs; [
      niri
      xwayland-satellite
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = "gnome";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
        };
      };
    };

    home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${cpaths.modules.home}/niri/hosts/${hostName}/"; 
  }; 
}
