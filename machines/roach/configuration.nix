{ config, pkgs, ... }:

{
  imports =
    [
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-030c69f0-dbc4-4276-945c-0bcfc0e9df68".device = "/dev/disk/by-uuid/030c69f0-dbc4-4276-945c-0bcfc0e9df68";
  boot.initrd.luks.devices."luks-030c69f0-dbc4-4276-945c-0bcfc0e9df68".keyFile = "/crypto_keyfile.bin";


  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.deviceSection = ''
  
    Option "TearFree" "true"
  '';


  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/Projects" = {
    device = "/dev/disk/by-uuid/f34277b3-b557-47a3-bf1b-f7a9368262d9";
    fsType = "ext4";

  };

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.containers.enable = true;
  virtualisation.containers.registries.search = [ "docker.io" ];

  # samba share browsing
  services.gvfs.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 ];

    extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
