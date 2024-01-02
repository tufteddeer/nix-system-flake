{ config, pkgs, ... }:
{
  virtualisation.oci-containers.containers.audiothek-feed = {
    image = "ghcr.io/tufteddeer/audiothek-feed:0.1.0";
    autoStart = true;
    ports = [ "3001:3000" ];
  };

}
