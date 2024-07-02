{
  description = "A flake for a minecraft server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosModules = {
      minecraft-server = { config, pkgs, ...}: {
        services.minecraft-server = {
          enable = true;
          eula = true;
          version = "1.20.4";
          motd = "Welcome to Birk's server!";
          maxPlayers = 10;
        };
        users.users.minecraft = {
          isNormalUser = true;
          home = "/var/lib/minecraft";
          description = "Minecraft server user";
          createHome = true;
        };

        networking.firewall.allowedTCPPorts = [ 25565 ];
      };
    };

    nixosConfigurations = {
      GLaDOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        {
          imports = [
            ../configuration.nix
            self.nixosModules.minecraft-server
          ];
        }
        ];
      };
    };
  };
}

