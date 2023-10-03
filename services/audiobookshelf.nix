{ config, pkgs, ... }:
{
  services.audiobookshelf = {
    enable = true;
    settings.bind_host = "192.168.178.20";
    openFirewall = true;
  };

}
