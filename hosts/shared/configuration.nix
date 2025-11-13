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

  r8125 = pkgs.callPackage ./drivers/r8125.nix { kernel = config.boot.kernelPackages.kernel; };

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
  ];

  programs.xwayland.enable = true;

  users.users.luh = {
    isNormalUser = true;
    description = "Lasse Ulf Hüffler";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "kvm"
    ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      vscode
      floorp-bin
      qemu
      quickemu
      virglrenderer
      spice
      dnsmasq
      phodav
    ];
  };

  programs.adb.enable = true;

  programs.zsh.enable = true;
  users.users.luh.shell = pkgs.zsh;

  fonts.packages = with pkgs; [
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

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
