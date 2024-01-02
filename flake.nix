{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
    let
      lib = nixpkgs.lib;

      authorized_keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVALmkXOYH56nfxUU9dWwpH3CoLfuTl6rKwTeQRry3KQvfk1EHdIm4jYJfxsb9OAX/xc3lKgOmm1Efjlwr5Tka2UjtL5AU+ZMdNYxNMIKcNaGxI8ot0L6LDeHp4fKwgz69B5K4hIdBgMbsURL0y+5WnGaicmuvuPR4SORPpm8HM6IzHg8Gfb/6DVHoagfz+BWhyGeC6JiISDthwKB2hNC0lK1zQuli/AyLLipW0awxMmeDLzxmyptmFAmke9s9QRPgBeixzeSIIWEhHpaBXudAjCIif7cUz4H0VEyJBf2/85ozSmukRir3bEClORKWlUfAPfZr9UDnBZElyZS0fqnoa+JCZo3QhHDH9/qT6VTurHF/8+mXTAL9tXL/zqk5op5agZA5MK6b8PpG8gRxunUYwWQaUf23bxZHK9MJftf6MjWPYTupUkn6g44NS/S1TT8915xKDpJSeFxlQw29NFzP69+SpD5KGMmFBgiWNbsfBr1ZCIH0sUwlNJAl0dPSndIAsZe91WAColm0Y8VzemdcsmYtUm5FUYzmAM0IiDOC+IgaIBhm2n02XV1jdUmUJxi1OTibuqm4aWVxveNhfgV5qjk5+BFZtdNhX3aI7ImW+w0hsM/SDcN0dNvsQCXqokrJZgM0ca0m9sFunCrpZ2BEjqyVNgap9QYvYYx+ZuNnzQ=="
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0X5Eoc7OBLqR/VuMTuichL+GhUYV0tAZBVlPiXMTVD f@aetron"
      ];
    in
    {
      nixosConfigurations = {
        normandy = lib.nixosSystem {

          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            ./machines/normandy/hardware-configuration.nix
            ./machines/normandy/configuration.nix

            ./nix-options.nix
            ./user.nix
            ./locale.nix

            ./services/freshrss.nix
            ./services/paperless.nix
            ./services/adguard.nix

            ./services/audiothek-feed.nix

            {
              networking.hostName = "normandy";
              users.users.f.openssh.authorizedKeys.keys = authorized_keys;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.f = import ./home.nix;
            }

          ];

        };

        stardust = lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            sops-nix.nixosModules.sops
            {
              sops.defaultSopsFile = ./secrets/secrets.yaml;
              sops.age.keyFile = "/var/lib/sops-nix/age/key.txt";
              sops.secrets.borg_repo = {};  
              sops.secrets.nas-media-credentials = {};          
            }
            
            ./machines/stardust/hardware-configuration.nix
            ./machines/stardust/configuration.nix

            ./nix-options.nix
            ./user.nix
            ./locale.nix

            # ./services/freshrss.nix
            ./services/paperless.nix
            ./services/adguard.nix
            ./services/audiothek-feed.nix
            ./services/reverse-proxy.nix

            ./services/navidrome.nix
            ./borgbackup.nix
            {
              networking.hostName = "stardust";
              users.users.f.openssh.authorizedKeys.keys = authorized_keys;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.f = import ./home.nix;
            }
          ];

        };

        roach = lib.nixosSystem rec {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            ./machines/roach/hardware-configuration.nix
            ./machines/roach/configuration.nix

            ./nix-options.nix
            ./user.nix
            ./locale.nix
            ./scanning-printing.nix
            ./nas.nix
            ./desktop-common.nix
            ./plasma.nix

            {
              networking.hostName = "roach";
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.f = import ./home.nix;
            }

            {
              environment.systemPackages = with pkgs; [
                logseq
                handbrake
                k3b
                picard
                makemkv

                gnome.gnome-boxes
              ];
            }

          ];

        };

        aetron = lib.nixosSystem rec {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            ./machines/aetron/hardware-configuration.nix
            ./machines/aetron/configuration.nix

            ./nix-options.nix
            ./user.nix
            ./locale.nix
            ./scanning-printing.nix
            ./nas.nix

            ./desktop-common.nix
            ./gnome.nix
            ./docker.nix

            {
              networking.hostName = "aetron";
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.f = import ./home.nix;
            }

            {
              services.udev.packages = [
                pkgs.platformio
                pkgs.openocd
              ];
            }
            {
              environment.systemPackages = with pkgs; [
                logseq
                handbrake
                makemkv
                arduino
                bitwarden
                drawio
                mediathekview
                ffmpeg
                chromium
                lapce
                zotero
                jetbrains.goland
                bruno
                krita
                unityhub
                jetbrains.rider
                wireshark
                platformio

                lsof
                killall
                pv
              ];
            }
          ];

        };

      };
    };
}
