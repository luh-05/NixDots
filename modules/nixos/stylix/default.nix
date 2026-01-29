{
  pkgs,
  lib,
  config,
  ...
}:

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
    # banger:
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = builtins.toFile "pop.json" (builtins.readFile ./pop.json);
    # base16Scheme = {
    #   base00 = "181c1f";
    #   base01 = "212121";
    #   base02 = "8a776f";
    #   base03 = "5b74b1";
    #   base0E = "3fa77f";
    #   base04 = "818f70";
    #   base05 = "e2e2e4";
    #   base06 = "f0f1f3";
    #   base07 = "f2f2f2";
    #   base08 = "557ff7"; # blue
    #   base09 = "d1af6c";
    #   base0A = "f38958";
    #   base0B = "e27e4f";
    #   base0C = "9fa1a3";
    #   base0D = "fde180";
    #   base0F = "83d7d7";
    # };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    # image = ./2.jpg;

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
