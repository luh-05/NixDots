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

    # extraConfig = ''
    #   DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
    #   DNSOverTLS=yes
    # '';
  };
  
  # networking.nameservers = [ "127.0.0.53" ];
}
