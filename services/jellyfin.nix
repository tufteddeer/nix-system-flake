{ config, pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "jellyfin";
  };

  users.users.jellyfin = {
    uid = 990;
    group = "jellyfin";
    isSystemUser = true;
  };

  users.groups.jellyfin = {
    gid = 989;
  };

  fileSystems."/run/media/jellyfin/NAS-Movies" = {
    device = "//192.168.178.2/home/Movies";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.jellyfin.uid},gid=${toString config.users.groups.jellyfin.gid}" ];
  };


}
