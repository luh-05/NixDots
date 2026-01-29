{
  inputs,
  config,
  options,
  ...
}:
let
  sr = 192000;
  q = 32;

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

  services.pipewire = {
    raopOpenFirewall = true;
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.pipewire.extraConfig.pipewire = {
    "92-low-latency" = {
      context.properties = {
        default.clock = {
          rate = sr;
          quantum = q;
          min-quantum = q;
          max-quantum = q;
        };
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
    # "10-airplay" = {
    #   context.modules = [
    #     {
    #       name = "libpipewire-module-raop-discover";
    #     }
    #   ];
    # };
    "10-raop-discover" = {
      context.properties = {

      };
    };
  };
}
