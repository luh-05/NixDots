{ config, pkgs, inputs, ... }:

let 
  home-manager-modules-path = ./../../modules/home-manager;
  hmmp = home-manager-modules-path;
in
{
  imports = 
    [
      "${hmmp}/nixvim/nixvim.nix"
      "${hmmp}/git/git.nix"
      "${hmmp}/alacritty/default.nix"
      "${hmmp}/zsh/default.nix"
      "${hmmp}/tmux/default.nix"
      "${hmmp}/hyprland/laptop.nix"
      "${hmmp}/wofi/default.nix"
      #"${hmmp}/swww/default.nix"
    ];

  home.username = "luh";
  home.homeDirectory = "/home/luh";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  home.file.".config/eww"  = {
    source = "${hmmp}/eww";
    recursive = true;
    executable = true;
  };


  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "3d21e4967b68e9ce80fb2238857aa1bf12c7b905";
        sha256 = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
      };
      cmakeFlags = [
        "-DUSE_WAYLAND_CLIPBOARD=1"
        "-DUSE_WAYLAND_GRIM=1"
      ];
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.libsForQt5.kguiaddons ];
    });
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    #jq # A lightweight and flexible command-line JSON processor
    #yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    zoxide
    thefuck
    tmux

    # networking tools
    #mtr # A network diagnostic tool
    #iperf3
    #dnsutils  # `dig` + `nslookup`
    #ldns # replacement of `dig`, it provide the command `drill`
    #aria2 # A lightweight multi-protocol & multi-source command-line download utility
    #socat # replacement of openbsd-netcat
    #nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    #hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    #neovim
    #nixvim
    discord
    webcord
    pavucontrol
    obs-studio
    #xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    qt5Full
    gst_all_1.gstreamer
    obs-studio-plugins.wlrobs
    brave
    ranger
    steam
    spotify
    meson
    ninja
    gcc

    xclip

    dunst
    libnotify

    playerctl
    grimblast

    plymouth

    inputs.swww.packages.${pkgs.system}.swww
    
    dolphin
    cinnamon.nemo-with-extensions
    feh
    imlib2Full
    haruna

    bibata-cursors

    eww
    spotifyd
    bash
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" "JetBrainsMono" ]; }) 
    
    piper
    libratbag

    keepassxc

    overskride

    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    hunspellDicts.de_DE
    obsidian 
  ];

  #stylix.package = inputs.stylix.homeMangerModules.stylix;

  #stylix.enable = true;

  #services.hyprpaper.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
