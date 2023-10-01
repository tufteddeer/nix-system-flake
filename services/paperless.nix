{ config, pkgs, ... }:
let
  backup_repo = "/backup/paperless-backup";
in
rec {
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    extraConfig.PAPERLESS_OCR_LANGUAGE = "deu+eng";
    passwordFile = "/run/secrets/paperless";
    dataDir = "/var/lib/paperless";
  };


  fileSystems."${backup_repo}" = {
    device = "//192.168.178.2/home/Backups/Homeserver/paperless-backup";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.paperless.uid}" ]; #",gid=${toString config.users.users.paperless.gid}"];
  };

  services.borgbackup.jobs.paperless = {
    paths = "${services.paperless.dataDir}";
    encryption.mode = "none";
    repo = backup_repo;
    compression = "zstd,1";
    startAt = "daily";
    user = "paperless";
    group = "paperless";

    exclude = [
      "${services.paperless.dataDir}/superuser-password"
      "${services.paperless.dataDir}/superuser-state"
    ];
  };
}

