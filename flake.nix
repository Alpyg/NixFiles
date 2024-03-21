{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit (import nixpkgs { inherit system; }) lib;

      homeManagerModules = hostname: [
        nixvim.homeManagerModules.nixvim
        ./home/${hostname}
      ];
    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/nixos ./nixos/pipewire.nix ./nixos/sws.nix ];
        };
        t470 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/t470 ./nixos/pipewire.nix ];
        };
        kuyin = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/kuyin ./nixos/pipewire.nix ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "alpyg@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };
          modules = homeManagerModules "nixos";
        };
        "alpyg@t470" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };
          modules = homeManagerModules "t470";
        };
        "kuyin@kuyin" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };
          modules = homeManagerModules "kuyin";
        };
      };
    };
}
