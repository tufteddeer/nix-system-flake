{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://famawe.net".extraConfig = ''
        #reverse_proxy http://localhost:58080
        respond "Hello"
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
