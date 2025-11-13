{
  config,
  pkgs,
  inputs,
  ...
}:

let
  home-manager-modules-path = ./../../modules/home-manager;
  hmmp = home-manager-modules-path;
in
{
  imports = [
    "${hmmp}/git/git.nix"
    "${hmmp}/alacritty/default.nix"
    "${hmmp}/zsh/default.nix"
    "${hmmp}/tmux/default.nix"
    "${hmmp}/hyprland/default.nix"
    "${hmmp}/wofi/default.nix"
    "${hmmp}/kitty/default.nix"
    "${hmmp}/helix/default.nix"
  ];

  home.username = "luh";
  home.homeDirectory = "/home/luh";

  # link all files in `./scripts` to `~/.config/i3/scripts` home.file.".config/i3/scripts" = {
  #   source = ./scripts; recursive = true; # link recursively executable = true; # make all files executable
  # };

  home.file.".config/eww" = {
    source = "${hmmp}/eww";
    recursive = true;
    executable = true;
  };

  wayland.windowManager.hyprland.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = "wlr";
        hyprland = [
          "gtk"
          "hyprland"
        ];
      };
    };
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # encode the file content in nix configuration file directly home.file.".xxx".text = ''
  #     xxx
  # '';

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      cudaSupport = true;
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    fastfetch

    zip
    xz
    unzip
    p7zip

    ripgrep
    eza
    zoxide
    tmux

    ipcalc

    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # it provides the command `nom` works just like `nix` with more details log output
    nix-output-monitor

    glow # markdown previewer in terminal

    btop

    strace

    sysstat
    lm_sensors
    pavucontrol

    gst_all_1.gstreamer
    brave
    ranger
    steam
    meson
    ninja
    gcc

    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })

    xclip

    dunst
    libnotify

    playerctl
    grimblast

    plymouth

    swww

    kdePackages.dolphin
    nemo-with-extensions
    feh
    imlib2Full
    haruna

    bibata-cursors

    eww
    spotifyd
    bash
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    (pkgs.callPackage "${hmmp}/fonts/interceptor-font.nix" { })

    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono

    piper
    libratbag

    keepassxc
    blueman

    zls

    jetbrains.idea-community
    zulu17
    monitor

    heroic
    wtype

    prismlauncher

    krita
    opentabletdriver

    gamescope

    cloudflare-warp

    bottles

    vscode
    iverilog

    libxkbcommon

    anydesk

    qdirstat

    protonup-qt
    revolt-desktop
    element-web

    ffmpeg
    signal-desktop

    protontricks
    wine

    steam-run

    nexusmods-app

    gthumb

    kitty
    timg
    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = [
      ];
    })
    fontfinder

    javaPackages.openjfx21
    gtk3
    libGL
    xorg.libXxf86vm

    libreoffice-qt6-fresh

    ghidra

    quickemu
    virt-manager

    linux-wallpaperengine

    spotify-cli-linux
    shotcut

    godot-mono

    mangohud
    gamemode

    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.qtimageformats
    kdePackages.kdesdk-thumbnailers
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kimageformats
    kdePackages.ffmpegthumbs
    kdePackages.taglib
    resvg

    tor-browser

    gnome-boxes
    xorg.xhost

    logseq

    llvm
  ];

  home.file."jdks/zulu23".source = pkgs.zulu23;

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
