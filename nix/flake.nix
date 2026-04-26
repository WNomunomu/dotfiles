{
  description = "kohsei's dotfiles (Nix part)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { system, hostModule }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/default.nix
            hostModule
          ];
        };
    in {
      homeConfigurations = {
        "kohsei@wsl" = mkHome {
          system = "x86_64-linux";
          hostModule = ./home/hosts/wsl.nix;
        };
      };
    };
}
