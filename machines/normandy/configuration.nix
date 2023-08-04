# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.lidSwitchDocked = "ignore";

  users.users.borg = {
    isNormalUser = true;
    extraGroups = [ "freshrss" "f" ];
  };

  # TODO: only user "borg" should have read and write on this
  fileSystems."/run/media/borg/backup" = {
      device = "//192.168.178.2/home/Backups/Homeserver";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1001,gid=1001"];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

  ];

  services.openssh = {
    enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      22
      443
      # adguard home
      3000
      # audiobookshelf
      8000
      8001

      # paperless
      58080

      # audiothekfeed
      3123
    ];
    allowedUDPPorts = [
      # adguard dns
      53
    ];
  };

  system.stateVersion = "23.05"; # Did you read the comment?

}
