{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    deploy-rs.url = "github:serokell/deploy-rs";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, sops-nix, deploy-rs, home-manager, catppuccin
    , nixvim, zig, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit (import nixpkgs { inherit system; }) lib;

      makeNixosSystem = modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };

          modules = [
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
          ] ++ modules;
        };
    in {
      nixosConfigurations = {
        nixos = makeNixosSystem [
          ./hosts/nixos
          ./services/kanata.nix
          catppuccin.nixosModules.catppuccin
          {
            home-manager.users.alpyg = {
              imports = [
                ./home/nixos.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
                { nixpkgs.overlays = [ zig.overlays.default ]; }
              ];
            };
          }
        ];
        t470 = makeNixosSystem [
          ./hosts/t470
          ./services/printer.nix
          catppuccin.nixosModules.catppuccin
          {
            home-manager.users.alpyg = {
              imports = [
                ./home/t470.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
              ];
            };
          }
        ];
        nexus = makeNixosSystem [
          ./hosts/nexus
          ./services/hostify.nix
          {
            home-manager.users.nexus = {
              imports = [ ./home/nexus.nix nixvim.homeManagerModules.nixvim ];
            };
          }
        ];
        kuyin = makeNixosSystem [
          ./hosts/kuyin
          {
            home-manager.users.kuyin = {
              imports = [ ./home/kuyin.nix nixvim.homeManagerModules.nixvim ];
            };
          }
        ];
      };

      deploy.nodes = {
        nixos = {
          hostname = "localhost";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.nixos;
          };
        };
        t470 = {
          hostname = "10.147.20.101";
          profiles.system = {
            user = "root";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.t470;
          };
        };
        nexus = {
          hostname = "10.147.20.99";
          profiles.system = {
            user = "root";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.nexus;
          };
        };
        kuyin = {
          hostname = "10.147.20.158";
          profiles.system = {
            user = "root";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.kuyin;
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
