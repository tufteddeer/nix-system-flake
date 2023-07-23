{ config, pkgs, ... }:
let
  dataDir = "/var/lib/freshrss";
in {
  services.freshrss = {
    enable = true;
    baseUrl = "http://192.168.178.20";
    passwordFile = "/run/secrets/freshrss";
    defaultUser = "admin";
    dataDir = "${dataDir}";
  };

  services.borgbackup.jobs.freshrss = {
    paths = "${dataDir}";
    encryption.mode = "none";
    repo = "/home/f/borgtest";
    compression = "zstd,1";
    startAt = "daily";
    user = "borg";
  };

}
