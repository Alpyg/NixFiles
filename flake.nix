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

    zig.url = "github:Alpyg/zig-overlay";
  };

  outputs = { self, nixpkgs, deploy-rs, catppuccin, nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      inherit (import nixpkgs { inherit system; }) lib;

      makeNixosSystem = modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./modules/nixos
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
          ] ++ modules;
        };
    in {
      nixosConfigurations = {
        nixos = makeNixosSystem [
          ./hosts/nixos
          {
            home-manager.users.alpyg = {
              imports = [
                ./home/nixos.nix
                ./modules/home-manager
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
                { nixpkgs.overlays = [ inputs.zig.overlays.default ]; }
              ];
            };
          }
        ];
        t470 = makeNixosSystem [
          ./hosts/t470
          {
            home-manager.users.alpyg = {
              imports = [
                ./home/t470.nix
                ./modules/home-manager
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
                { nixpkgs.overlays = [ inputs.zig.overlays.default ]; }
              ];
            };
          }
        ];
        nexus = makeNixosSystem [
          ./hosts/nexus
          {
            home-manager.users.nexus = {
              imports = [
                ./home/nexus.nix
                ./modules/home-manager
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
              ];
            };
          }
        ];
        kuyin = makeNixosSystem [
          ./hosts/kuyin
          {
            home-manager.users.kuyin = {
              imports = [
                ./home/kuyin.nix
                ./modules/home-manager
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
              ];
            };
          }
        ];
      };

      deploy.nodes = {
        nixos = {
          hostname = "localhost";
          profiles.system = {
            sshUser = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.nixos;
          };
        };
        t470 = {
          hostname = "10.147.20.101";
          profiles.system = {
            sshUser = "alpyg";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.t470;
          };
        };
        nexus = {
          hostname = "10.147.20.99";
          profiles.system = {
            sshUser = "nexus";
            user = "root";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.nexus;
          };
        };
        kuyin = {
          hostname = "10.147.20.158";
          profiles.system = {
            sshUser = "kuyin";
            user = "kuyin";
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
