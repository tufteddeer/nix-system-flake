{ config, pkgs, ... }:
rec {  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    extraConfig.PAPERLESS_OCR_LANGUAGE = "deu+eng";
    passwordFile = "/run/secrets/paperless";
    dataDir = "/var/lib/paperless";
  };


  services.borgbackup.jobs.paperless = {
    paths = "${services.paperless.dataDir}";
    encryption.mode = "none";
    repo = "/home/borg/borgtest";
    compression = "zstd,1";
    startAt = "daily";
    user = "borg";

    exclude = [
      "${services.paperless.dataDir}/superuser-password" 
    ];
  };
}
