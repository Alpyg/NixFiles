{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";

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

  outputs =
    { self, nixpkgs, home-manager, catppuccin, nixvim, zig, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit (import nixpkgs { inherit system; }) lib;

      homeManagerModules = hostname: [
        nixvim.homeManagerModules.nixvim
        catppuccin.homeManagerModules.catppuccin
        { nixpkgs.overlays = [ zig.overlays.default ]; }
        ./home/${hostname}.nix
      ];
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            catppuccin.nixosModules.catppuccin
            ./nixos/nixos
            #./nixos/.modules/ap.nix
          ];
        };
        t470 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            catppuccin.nixosModules.catppuccin
            ./nixos/t470
            ./nixos/printer.nix
          ];
        };
        nexus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/nexus ./nixos/.modules/hostify.nix ];
        };
        kuyin = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/kuyin ];
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
        "nexus@nexus" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { allowUnfree = true; };
          };
          modules = homeManagerModules "nexus";
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
