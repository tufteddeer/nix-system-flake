{ config, pkgs, ... }:
{
  services.borgbackup.jobs.stardust-backup = {
    paths = [
      "${config.services.paperless.dataDir}"
      "/volumes"
      "/home/f/.local/share/containers/storage/volumes/"
    ];
    exclude = [
      "/volumes/navidrome_music_data/cache"
      "/volumes/navidrome_audiobooks_data/cache"
    ];
    encryption.mode = "keyfile-blake2";
    encryption.passCommand = "cat /borg-repo-passphrase";
    compression = "zstd,1";
    startAt = ["daily"];

    # use sops-nix to avoid leaking ssh usernames and hosts
    preHook = ''
      BORG_REPO="$(cat ${config.sops.secrets.borg_repo.path})"

      systemctl stop paperless-consumer.service
      systemctl stop paperless-scheduler.service
      systemctl stop paperless-task-queue.service
      systemctl stop paperless-web.service
      systemctl stop redis-paperless.service
    '';

    postHook = ''
      if [ $exitStatus == 0 ]; then
        STATUS=up
      else
        STATUS=down
      fi
      
      systemctl start paperless-consumer.service
      systemctl start paperless-scheduler.service
      systemctl start paperless-task-queue.service
      systemctl start paperless-web.service
      systemctl start redis-paperless.service

      ${pkgs.curl}/bin/curl "http://krempel.xyz:4000/api/push/oC75GrcKfr?status=$STATUS&msg=$exitStatus"


    '';
    repo = "placeholder";
  };
}
