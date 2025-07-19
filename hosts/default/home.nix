{ config, pkgs, inputs, ... }:

let home-manager-modules-path = ./../../modules/home-manager; hmmp = home-manager-modules-path;
in {
  imports = [
      #"${hmmp}/nixvim/nixvim.nix"
      "${hmmp}/git/git.nix"
      "${hmmp}/alacritty/default.nix"
      "${hmmp}/zsh/default.nix"
      "${hmmp}/tmux/default.nix"
      "${hmmp}/hyprland/default.nix" 
      "${hmmp}/wofi/default.nix"
      "${hmmp}/kitty/default.nix"
      "${hmmp}/helix/default.nix"
      #"${hmmp}/alvr/default.nix"
      #"${hmmp}/nvf/main.nix"
      #"${hmmp}/swww/default.nix"
    ];

  home.username = "luh"; home.homeDirectory = "/home/luh";

  # link the configuration file in current directory to the specified location in home directory home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts` home.file.".config/i3/scripts" = {
  #   source = ./scripts; recursive = true; # link recursively executable = true; # make all files executable
  # };

  home.file.".config/eww" = { source = "${hmmp}/eww"; recursive = true; executable = true;
  };

  wayland.windowManager.hyprland.xwayland.enable = true;


  # encode the file content in nix configuration file directly home.file.".xxx".text = ''
  #     xxx
  # '';


  nixpkgs = { config = {
      allowUnfree = true; allowUnfreePredicate = (_: true); cudaSupport = true;
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently feel free to add your own or remove some of them

    fastfetch

    # archives
    zip xz unzip p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    #jq # A lightweight and flexible command-line JSON processor yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’ fzf
    # A command-line fuzzy finder
    zoxide tmux

    # networking tools mtr # A network diagnostic tool iperf3 dnsutils # `dig` + `nslookup` ldns # replacement of `dig`, it provide the command `drill` aria2 # A 
    #lightweight multi-protocol & multi-source command-line download utility socat # replacement of openbsd-netcat nmap # A utility for network discovery and 
    #security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay file which tree gnused gnutar gawk zstd gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix` with more details log output
    nix-output-monitor

    # productivity hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon iotop # io monitoring iftop # network monitoring

    # system call monitoring
    strace # system call monitoring ltrace # library call monitoring lsof # list open files

    # system tools
    sysstat lm_sensors # for `sensors` command ethtool pciutils # lspci usbutils # lsusb
    #neovim nixvim discord webcord
    pavucontrol obs-studio qt5Full gst_all_1.gstreamer
    #xdg-desktop-portal-wlr obs-studio-plugins.wlrobs
    brave ranger steam meson ninja gcc

    (discord.override {
      withOpenASAR = true; # can do this here too
      withVencord = true;
    })

    xclip

    dunst libnotify

    playerctl grimblast

    plymouth

    #inputs.swww.packages.${pkgs.system}.swww
    swww
    
    kdePackages.dolphin nemo-with-extensions feh imlib2Full haruna

    bibata-cursors

    eww spotifyd bash 
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    (pkgs.callPackage "${hmmp}/fonts/interceptor-font.nix" { })
    #(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" "JetBrainsMono" ]; })
   
    nerd-fonts.fira-code nerd-fonts.droid-sans-mono nerd-fonts.iosevka nerd-fonts.jetbrains-mono

    piper libratbag

    keepassxc blueman

    zls

    jetbrains.idea-community
    zulu17
    #openjdk17-bootstrap
    monitor stacer

    heroic wtype

    prismlauncher

    krita opentabletdriver

    lmstudio

    gamescope

    cloudflare-warp

    bottles

    vscode iverilog

    libxkbcommon

    anydesk

    qdirstat

    protonup-qt revolt-desktop element-web

    ffmpeg signal-desktop

    protontricks lutris wine

    nexusmods-app

    gthumb

    kitty
    timg

    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = [
        inkscape-extensions.applytransforms
      ];
    })
    fontfinder 

    kicad

    javaPackages.openjfx21
    gtk3
    libGL
    xorg.libXxf86vm

    libreoffice-qt6-fresh

    ghidra

    qemu quickemu
    virt-manager

    linux-wallpaperengine

    spotify-cli-linux
    shotcut

    godot-mono
  ];
  
  home.file."jdks/zulu23".source = pkgs.zulu23;

  # For Monado:
  #xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
  # For WiVRn:
  #xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

    #xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    #  {
    #    "config" :
    #    [
    #      "${config.xdg.dataHome}/Steam/config"
    #    ],
    #    "external_drivers" : null,
    #    "jsonid" : "vrpathreg",
    #    "log" :
    #    [
    #      "${config.xdg.dataHome}/Steam/logs"
    #    ],
    #    "runtime" :
    #    [
    #      "${pkgs.opencomposite}/lib/opencomposite"
    #    ],
    #    "version" : 1
    #  }
    #'';

  #stylix.package = inputs.stylix.homeMangerModules.stylix;

  #stylix.enable = true;

  #services.hyprpaper.enable = true;

  # This value determines the home Manager release that your configuration is compatible with. This helps avoid breakage when a new home Manager release 
  # introduces backwards incompatible changes.
  #
  # You can update home Manager without changing this value. See the home Manager release notes for a list of state version changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
