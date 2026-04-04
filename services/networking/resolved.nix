{
  inputs,
  config,
  options,
  ...
}:
let

in
{
  services.resolved = {
    enable = true;

    dnssec = "true";
    domains = [ "~." ]; # route all DNS though resolved

    #fallbackDns = [
    #  "9.9.9.9"
    #  "149.112.112.112"
    #  "2620:fe::fe"
    #  "2620:fe::9"
    #];

    settings = {
      Resolve.DNSOverTLS="false";
    };
  };
  
  # networking.nameservers = [ "127.0.0.53" ];
}
