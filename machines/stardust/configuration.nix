{ config, pkgs, ... }:

{
  imports =
    [
    ];

  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # environment.systemPackages = with pkgs; [
  #   
  # ];

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

  system.stateVersion = "23.11"; # Did you read the comment?

}
