{ config, pkgs, ... }:
{
  services.borgbackup.jobs.stardust-backup = {
    paths = [
      "${config.services.paperless.dataDir}"
      "/volumes"    
    ];
    encryption.mode = "keyfile-blake2";
    encryption.passCommand = "cat /borg-repo-passphrase";
    compression = "zstd,1";
    startAt = ["daily"];

    # use sops-nix to avoid leaking ssh usernames and hosts
    preHook = ''
      BORG_REPO="$(cat ${config.sops.secrets.borg_repo.path})"
    '';
    repo = "placeholder";
  };
}
