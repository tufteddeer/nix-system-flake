{ config, pkgs, ... }:
{
  services.plausible = {
    enable = true;
    server = {
      baseUrl = "https://plausible.krempel.xyz";
      port = 80;
      secretKeybaseFile = config.sops.secrets.borg_repo.path;
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 80 ];
}


