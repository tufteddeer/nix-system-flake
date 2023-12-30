{ config, pkgs, ... }:

{
  imports =
    [
    ];

 boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0f167b21-2667-4f54-9aa8-dd5c9e8dff7d".device = "/dev/disk/by-uuid/0f167b21-2667-4f54-9aa8-dd5c9e8dff7d";

  users.users.borg = {
    isNormalUser = true;
    extraGroups = [ "freshrss" "f" ];
  };

  services.openssh = {
    enable = true;
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      22
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}
