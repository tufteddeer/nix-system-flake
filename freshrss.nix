{ config, pkgs, ... }:
{
  services.freshrss = {
    enable = true;
    baseUrl = "http://192.168.178.20";
    passwordFile = "/run/secrets/freshrss";
    defaultUser = "admin";
  };
}
