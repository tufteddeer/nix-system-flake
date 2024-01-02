{ config, pkgs, lib, ... }:
let
  musicDir = "/media/NAS_Music";
  audiobooksDir = "/media/NAS_Audiobooks";
  navidromeUID = 2000;
  navidromeUser = {
    uid = navidromeUID;
    isSystemUser = true;
    group = "navidrome";
  };
in
{

  fileSystems."${musicDir}" = {
    device = "//192.168.178.2/Music";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=${config.sops.secrets.nas-media-credentials.path}" ];
  };

  fileSystems."${audiobooksDir}" = {
    device = "//192.168.178.2/Audiobooks";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=${config.sops.secrets.nas-media-credentials.path}" ];
  };

  users.users.navidrome = navidromeUser;
  users.groups.navidrome = { };

  virtualisation.oci-containers.containers.navidrome-music = {
    user = "${toString navidromeUID}:${toString navidromeUID}";
    ports = [
      "4533:4533"
    ];
    volumes = [
      "${musicDir}:/music:ro"
      "/volumes/navidrome_music_data:/data"
    ];
    image = "deluan/navidrome:0.50.2";
    autoStart = true;
  };

  virtualisation.oci-containers.containers.navidrome-audiobooks = {
    user = "${toString navidromeUID}:${toString navidromeUID}";
    ports = [
      "4534:4533"
    ];
    volumes = [
      "${audiobooksDir}:/music:ro"
      "/volumes/navidrome_audiobooks_data:/data"
    ];
    image = "deluan/navidrome:0.50.2";
    autoStart = true;
  };
}
