{ config, pkgs, ... }:
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
