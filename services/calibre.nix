{ config, pkgs, ... }:
let
  port = "8083";
  version = "0.6.24";
in
{


    virtualisation.oci-containers.containers.calibre = {
        image = "lscr.io/linuxserver/calibre-web:${version}";
        autoStart = true;
    ports = [
        "${port}:${port}"
    ];

    volumes = [
      "/volumes/calibre_books:/books"
      "/volumes/calibre_config:/config"
    ];

    };
    networking.firewall.allowedTCPPorts = [ 8083 ];
}
