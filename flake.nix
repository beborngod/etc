{
  description = "alx's home-manager setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "aarch64-darwin";
    user   = "alexiusbelov";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (_: _: {
          ghostty-bin = nixpkgs-unstable.legacyPackages.${system}.ghostty-bin;
        })
      ];
    };
  in {
    homeConfigurations.alx = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        {
          home = {
            username = user;
            homeDirectory = "/Users/${user}";
            stateVersion = "24.05";
          };
        }
        ./nix/home.nix
        ./nix/shell.nix
        ./nix/tmux.nix
        ./nix/dev.nix
      ];
    };
  };
}
