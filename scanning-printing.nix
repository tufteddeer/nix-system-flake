{ config, pkgs, ... }:
{
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # scanning
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.epkowa ];

  # printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  environment.systemPackages = with pkgs; [
    gnome.simple-scan
  ];
}
