{ config, pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    settings.bind_host = "192.168.178.20";
  };
}
