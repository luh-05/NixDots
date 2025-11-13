{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:

let
  shared-config-path = ./../shared;
  scp = shared-config-path;
in
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
  ];

  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.xserver.displayManager.setupCommands = ''
    xrandr --output DP-4 --primary
  '';
  # services.monado = {
  #   enable = true;
  #   defaultRuntime = true;
  # };
  # systemd.user.services.monado.environment = {
  #   STEAMVR_LH_ENABLE = "1";
  #   XRT_COMPOSITOR_COMPUTE = "1";
  #   WMR_HANDTRACKING = "0";
  # };
  # services.wivrn = {
  #   enable = true;
  #   openFirewall = true;

  #   # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
  #   # will automatically read this and work with WiVRn (Note: This does not currently
  #   # apply for games run in Valve's Proton)
  #     defaultRuntime = false;

  #   # Run WiVRn as a systemd service on startup
  #   autoStart = true;

  #   # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
  #   config = {
  #     enable = true;
  #     json = {
  #       # 1.0x foveation scaling
  #       scale = 1.0;
  #       # 100 Mb/s
  #       bitrate = 100000000;
  #       encoders = [
  #         {
  #           encoder = "vaapi";
  #           codec = "h265";
  #           # 1.0 x 1.0 scaling
  #           width = 1.0;
  #           height = 1.0;
  #           offset_x = 0.0;
  #           offset_y = 0.0;
  #         }
  #       ];
  #     };
  #   };
  # };
  programs.envision = {
    enable = true;
    openFirewall = true; # This is set true by default
  };

  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
    enableVirtualCamera = true;
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luh" = import ./home.nix;
    };
  };

  networking.bridges = {
    mylxdbr0.interfaces = [ ];
  };
  networking.localCommands = ''
    ip address add 192.168.57.1/24 dev mylxdbr0
  '';
  networking.firewall.extraCommands = ''
    iptables -A INPUT -i mylxdbr0 -m comment --comment "my rule for LXD network mylxdbr0" -j ACCEPT

    # These three technically aren't needed, since by default the FORWARD and
    # OUTPUT firewalls accept everything everything, but lets keep them in just
    # in case.
    iptables -A FORWARD -o mylxdbr0 -m comment --comment "my rule for LXD network mylxdbr0" -j ACCEPT
    iptables -A FORWARD -i mylxdbr0 -m comment --comment "my rule for LXD network mylxdbr0" -j ACCEPT
    iptables -A OUTPUT -o mylxdbr0 -m comment --comment "my rule for LXD network mylxdbr0" -j ACCEPT

    iptables -t nat -A POSTROUTING -s 192.168.57.0/24 ! -d 192.168.57.0/24 -m comment --comment "my rule for LXD network mylxdbr0" -j MASQUERADE
  '';
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  virtualisation = {
    waydroid.enable = true;
    lxc.lxcfs.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu.override {
        };
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  users.users."luh" = {
    extraGroups = [ "libvirtd" ];
  };
}
