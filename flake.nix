{
  description = "alx's home-manager setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      firefox-addons,
      zen-browser,
      ...
    }:
    let
      system = "aarch64-darwin";
      user = "alexiusbelov";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          firefox-addons.overlays.default
          (_: _: {
            ghostty-bin = nixpkgs-unstable.legacyPackages.${system}.ghostty-bin;
            zen-browser = zen-browser.packages.${system}.default;
          })
        ];
      };
    in
    {
      formatter.${system} = pkgs.nixfmt;
      homeConfigurations.alx = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit zen-browser; };

        modules = [
          {
            home = {
              username = user;
              homeDirectory = "/Users/${user}";
              stateVersion = "24.05";
            };
          }
          ./nix/home.nix
          ./nix/zen.nix
          ./nix/shell.nix
          ./nix/tmux.nix
          ./nix/dev.nix
        ];
      };
    };
}
