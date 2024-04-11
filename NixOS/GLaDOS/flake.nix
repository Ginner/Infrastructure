{
  description = "agenix flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, agenix, ... }@attrs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations.GLaDOS = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        agenix.nixosModules.default
      ];
      specialArgs = { inherit attrs; };
    };
  };
}
