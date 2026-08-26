{
  inputs,
  config,
  options,
  ...
}:
let
  sr = 48000;
  q = 512;
  # sr = 192000;
  # q = 512;

  pulse = "${builtins.toString q}/${builtins.toString sr}";
in
{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.avahi = {
    enable = true;
    hostName = "Gary";
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  # services.shairport-sync = {
  #   enable = true;
  #   settings = {
  #     name = "Greg";
  #     ouput_backend = "pw";
  #     metadata = {
  #       cover_art_cache_directory = "/tmp/shairport-sync/.cache/coverart";
  #       enabled = "yes";
  #       include_cover_art = "yes";
  #       pipe_name = "/tmp/shairport-sync-metadata";
  #       pipe_timeout = 5000;
  #     };
  #     # mqtt = {
  #     #   enabled = "yes";
  #     #   # hostname = "mqtt.server.domain.example";
  #     #   port = 1883;
  #     #   publish_cover = "yes";
  #     #   publish_parsed = "yes";
  #     # };
  #   };
  # };

  users.users.shairport = {
    isSystemUser = true;
    extraGroups = [ "audio" ];
  };

  services.shairport-sync = {
    enable = true;

    user = "shairport";

    settings = {
      general = {
        name = "NixOS Shairport";
        output_backend = "pulseaudio";
        mdns_backend = "avahi";
      };
      pulseaudio = {
        server = "127.0.0.1";
      };
      alsa = {
        # output_device = "plughw:1,0";
        # output_device = "default";
        # mixer_control_name = "PCM";
      };
    };
    openFirewall = true;
  };

  # systemd.services.shairport-sync.environment = {
  #   "XDG_RUNTIME_DIR" = "/run/user/1000";
  # };

  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [
  #     5000
  #     7000
  #   ];
  #   allowedUDPPorts = [
  #     5353
  #     6000
  #     6001
  #     6002
  #     6003
  #     7000
  #   ];
  #   allowedUDPPortRanges = [
  #     {
  #       from = 6000;
  #       to = 6010;
  #     }
  #   ];
  # };

  services.pipewire = {
    # raopOpenFirewall = true;
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    extraConfig.pipewire-pulse."10-tcp" = {
      "pulse.properties" = {
        "server.address" = [
          "unix:native"
          "tcp:127.0.0.1:4713"
        ];
      };
    };
  };

  services.pipewire.extraConfig.pipewire = {
    "92-low-latency" = {
      "context.properties" = {
        # "default.clock" = {
        #   "rate" = sr;
        #   "quantum" = q;
        #   "min-quantum" = q;
        #   "max-quantum" = q;
        # };
        "default.clock.rate" = sr;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
          192000
        ];
        "default.clock.quantum" = q;
        "default.clock.min-quantum" = q;
        "default.clock.max-quantum" = q;
      };
      pulse.properties = {
        pulse.min.req = pulse;
        pulse.default.req = pulse;
        pulse.max.req = pulse;
        pulse.min.quantum = pulse;
        pulse.max.quantum = pulse;
      };
      stream.properties = {
        node.latency = pulse;
        resample.quality = 1;
      };
    };
    "51-optical-limit" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "alsa_output.pci-0000_11_00.6.iec958-stereo";
            }
          ];
        }
      ];
      actions = {
        "audio.allowed-rates" = "[ 41000 48000 88200 96000 ]";
        "audio.rate" = 48000;
      };
    };
    # "10-airplay" = {
    #   context.modules = [
    #     {
    #       name = "libpipewire-module-raop-discover";
    #     }
    #   ];
    # };
    # "10-raop-discover" = {
    #   context.properties = {
    #
    #   };
    # };
  };
}
