{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    oxygen
    plasma-browser-integration
  ];
}
