{ pkgs, lib, config, ... }:

{
  stylix = {
    enable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/solarflare.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    #image = ./backgrounds/illustration-rain-futuristic-city.jpg;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./1.png;

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 1.0;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        #package = pkgs.nerdfonts.override {fonts = ["FiraMono"];};
        name = "FiraMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        #package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
    };

    targets = {
      nixos-icons = {
        enable = false;
      };

      plymouth = {
        enable = true;
        logo = ./logos/nixos.svg;
      };

      nixvim = {
        enable = true;
        transparentBackground.main = true; 
      };

      gtk.enable = true;

      #kitty.enable = true;
    };
  };
}
