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

  currentDirectory = builtins.getEnv "PWD";

  r8125 = pkgs.callPackage ./drivers/r8125.nix { kernel = config.boot.kernelPackages.kernel; };

in
{
  environment.etc."debug-current-directory".text = currentDirectory;
  environment.etc."debug-nixos-path".text = builtins.toString nmp;
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
  ];

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  #};

  #boot.kernelModules = [ "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia" ];
  #boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
  #boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

  boot.kernelModules = [
    "nf_nat_ftp"
    "v4l2loopback'"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=1,2 card_label="OBS Cam, Virt Cam" exclusive_caps=1
  '';
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  hardware.bluetooth.enable = true;

  # nixpkgs.config.permittedInsecurePackages = [
  #   "gradle-7.6.6"
  # ];

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.wayland}/lib:$LD_LIBRARY_PATH";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  #fileSystems."/data" =
  #{
  #  device = "/dev/disk/by-partuuid/bcf874b7-02";
  #  fsType = "ntfs-3g";
  #  options = [ "rw" "uid=1000"];
  #};
  #fileSystems."/para" =
  #{
  #  device = "/dev/disk/by-partuuid/3275efc2-5142-4685-9bcc-ef930a9ed7ed";
  #  fsType = "ntfs-3g";
  #  options = [ "rw" "uid=1000"];
  #};

  programs.hyprland.enable = true;

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.graphics = {
    enable = true;
    #driSupport = true;
    enable32Bit = true;
  };

  programs.xwayland.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.lightdm.enable = false;
  # services.xserver.desktopManager.plasma5.enable = false;

  services.cloudflare-warp.enable = true;

  services.ratbagd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
      firefox
      kdePackages.kate
      #spotify
      alacritty
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

  #services.hyprpaper.enable = true;

  programs.adb.enable = true;

  programs.zsh.enable = true;
  users.users.luh.shell = pkgs.zsh;

  #home-manager = {
  #  backupFileExtension = "backup";
  #  extraSpecialArgs = { inherit inputs; };
  #  users = {
  #    "luh" = import ./home.nix;
  #  };
  #};

  #fonts.packages = with pkgs; [ fira-code ];
  fonts.packages = with pkgs; [
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    #(nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "DroidSansMono" "Iosevka" "JetBrainsMono" ]; })
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  environment.variables.EDITOR = "nvim";

  #boot.extraModulePackages = [ r8125 ];

  boot.blacklistedKernelModules = [ "r8169" ];

  #boot.kernelModules = [ "r8125" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
