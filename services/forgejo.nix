{ config, pkgs, ... }:
{
  services.forgejo = {
    enable = true;
    settings = {
      server.ROOT_URL = "http://git.krempel.xyz";
      server.HTTP_PORT = 7000;
    };
  };
}

