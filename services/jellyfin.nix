{ config, pkgs, ... }:
{

  fileSystems."/media/NAS_Movies" = {
     device = "//192.168.178.2/Movies";
     fsType = "cifs";
     options =
       let
         # this line prevents hanging on network split
         automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
       in
       [ "${automount_opts},credentials=${config.sops.secrets.nas-media-credentials.path}" ];
  };

 fileSystems."/media/NAS_Shows" = {
   device = "//192.168.178.2/Shows";
   fsType = "cifs";
   options =
     let
        # this line prevents hanging on network split
       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=${config.sops.secrets.nas-media-credentials.path}" ];
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  services.jellyfin = {
    enable = true;
  };
}
