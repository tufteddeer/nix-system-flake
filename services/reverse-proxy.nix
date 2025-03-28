{ config, pkgs, ... }:
let
  host = "krempel.xyz";
in
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://${host}".extraConfig = ''
        #reverse_proxy http://localhost:58080
        respond "Hello"
      '';

      "http://paperless.${host}".extraConfig = ''
        reverse_proxy http://localhost:58080
      '';

      "http://audiothek.${host}".extraConfig = ''
        reverse_proxy http://localhost:3001
      '';

      "http://adguard.${host}".extraConfig = ''
        reverse_proxy http://localhost:3000
      '';

      "http://music.${host}".extraConfig = ''
        reverse_proxy http://localhost:4533
      '';

      "http://audiobooks.${host}".extraConfig = ''
        reverse_proxy http://localhost:4534
      '';

      "http://grafana.${host}".extraConfig = ''
        reverse_proxy http://localhost:6000
      '';

      "http://status.${host}".extraConfig = ''
        reverse_proxy http://localhost:4000
      '';

      "http://jellyfin.${host}".extraConfig = ''
        reverse_proxy http://localhost:8096
      '';

      "http://audiobookshelf.${host}".extraConfig = ''
        reverse_proxy http://localhost:8000
      '';

       "http://ghostfolio.${host}".extraConfig = ''
        reverse_proxy http://localhost:3333
      '';

       "http://tandoor.${host}".extraConfig = ''
        reverse_proxy http://localhost:8200
      '';

      "http://calibre.${host}".extraConfig = ''
        reverse_proxy http://localhost:8083
      '';

    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
