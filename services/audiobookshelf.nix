{ config, pkgs, ... }:
let
  audiobooksDir = "/media/NAS_Audiobooks";
in
{

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

    containers.audiobookshelf = {
    autoStart = true;
  #   privateNetwork = true;
  # hostAddress = "192.168.100.10";
  # localAddress = "192.168.100.11";
  # hostAddress6 = "fc00::1";
  # localAddress6 = "fc00::2";
    forwardPorts = [
      {
        containerPort = 8000;
        hostPort = 8000;
        protocol = "tcp";
      }

    ];
    
    bindMounts."/media/audiobooks" = {
      
      hostPath = "${audiobooksDir}";
      isReadOnly = true;
    };
      

    config = {config, pkgs, ...}: {
      system.stateVersion = "23.11";

      services.audiobookshelf = {
        enable = true;

        host = "0.0.0.0";
        port = 8000;
        openFirewall = true;
      };



    };
  };
}
