{ config, pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    settings.bind_host = "192.168.178.20";
    settings.schema_version = 20;
    openFirewall = true;
  };
}
