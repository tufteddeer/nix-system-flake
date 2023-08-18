{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "f";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    oxygen
    plasma-browser-integration
  ];


  environment.systemPackages = with pkgs; [
    alacritty
    spotify
    thunderbird
    vlc
    libreoffice-fresh
    discord
    ark
    keepassxc
    nextcloud-client
    firefox
    libsForQt5.filelight
    okular
    kate
  ];

}
