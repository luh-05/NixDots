{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:

let
  nixos-modules-path = ./../../modules/nixos;
  nmp = nixos-modules-path;
  home-manager-module-path = ./../../modules/home-manager;
  hmmp = home-manager-module-path;

in
{
  imports = [
    inputs.home-manager.nixosModules.default

    #inputs.stylix.nixosModules.stylix
    "${nmp}/stylix/default.nix"

    #inputs.nixvim.homeManagerModules.nixvim
    # ./modules/neovim/neovim.nix

    "${nmp}/alvr/default.nix"
    "${nmp}/starship/default.nix"
    "${hmmp}/spicetify/default.nix"

    ./services.nix
    ./config/boot.nix
    ./config/environment.nix
    ./config/hardware.nix
    ./config/networking.nix
    ./config/fonts.nix
    ./config/users.nix
  ];

  programs.xwayland.enable = true;

  programs.adb.enable = true;

  programs.zsh.enable = true;
  users.users.luh.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gphoto2
    v4l-utils
    wget
    gitFull
    curl
    zsh
    #inputs.helix.packages."${pkgs.system}".helix
    nodejs
    cmake
    vulkan-tools-lunarg
    vulkan-headers
    vulkan-loader
    vulkan-volk
    vulkan-validation-layers
    wayland-scanner
    pkg-config
    wlroots
    python3
    pipx
    obsidian
    clang-tools
    psmisc
    base16-schemes
    exfat
    exfatprogs
    egl-wayland
    grim
    slurp
    obs-studio-plugins.wlrobs
    wayland
    waylandpp
    #xlib
    starship
    monado-vulkan-layers

    #linuxKernel.packages.linux_zen.r8125
    ethtool
    mesa
    looking-glass-client
  ];

  # dont change this
  system.stateVersion = "23.11";
}
