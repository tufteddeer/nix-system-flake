{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.f = {
    isNormalUser = true;
    description = "f";
    extraGroups = [ "wireshark" "networkmanager" "wheel" "cdrom" "dialout" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };
}
