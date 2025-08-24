{
  description = "NixOS repo: desktop + WSL, modular, HM-as-module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, treefmt-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [ treefmt-nix.flakeModule ];

      perSystem = { pkgs, system, ... }: {
        formatter = pkgs.nixfmt-classic;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ git nixfmt-classic nil ];
        };
        treefmt.config.programs.nixfmt.enable = true;
      };

      flake = {
        nixosConfigurations = {
          wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              inputs.nixos-wsl.nixosModules.default
              ./hosts/wsl
              ./profiles/base.nix
              ./profiles/dev.nix
              ./users/dev
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useUserPackages = true;
                home-manager.users.dev = import ./home/dev/common.nix;
              }
              inputs.nix-index-database.nixosModules.nix-index
              inputs.sops-nix.nixosModules.sops
            ];
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/desktop
              ./profiles/base.nix
              ./profiles/dev.nix
              ./profiles/desktop-gnome.nix
              ./users/dev
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useUserPackages = true;
                home-manager.users.dev = import ./home/dev/desktop.nix;
              }
              inputs.nix-index-database.nixosModules.nix-index
              inputs.sops-nix.nixosModules.sops
            ];
          };
        };
      };
    };
}
