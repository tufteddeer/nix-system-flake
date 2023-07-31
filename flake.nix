{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        normandy = lib.nixosSystem rec {

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

            { networking.hostName = "normandy"; }

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
            system = "aarch64-linux";
            config = { allowUnfree = true; };
          };

          modules = [
            ./machines/stardust/hardware-configuration.nix
            ./machines/stardust/configuration.nix

            ./nix-options.nix
            ./user.nix
            ./locale.nix

            ./services/freshrss.nix
            ./services/paperless.nix
            ./services/adguard.nix

            { networking.hostName = "stardust"; }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.f = import ./home.nix;
            }

          ];

        };

      };
    };
}
