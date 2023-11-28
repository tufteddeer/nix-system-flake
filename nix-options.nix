{ config, pkgs, ... }:
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.settings.auto-optimise-store = true;

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;
}
