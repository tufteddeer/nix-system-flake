{ config, pkgs, ... }:
{

  virtualisation.oci-containers.containers.adguardhome = {
    image = "adguard/adguardhome:v0.107.53";
    autoStart = true;
    ports = [
      "53:53/udp"
      "3000:3000"
    ];
    volumes = [
      "/volumes/adguard_workdir:/opt/adguardhome/work"
      "/volumes/adguard_confdir:/opt/adguardhome/conf"
    ];
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
}
