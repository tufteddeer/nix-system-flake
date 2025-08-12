# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{

  boot.loader.grub = {
      device = [ "/dev/vda2"];
      # efi values are taken from https://github.com/nix-community/nixos-anywhere-examples/blob/main/configuration.nix
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  
    system.stateVersion = "25.11"; # Did you read the comment?
 
 }