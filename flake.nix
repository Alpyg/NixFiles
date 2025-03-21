{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";

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

  outputs = { self, nixpkgs, ... }@inputs:
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
            inputs.hyprland.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.catppuccin.nixosModules.catppuccin
          ] ++ modules;
        };

      makeHomeManager = user: home: {
        home-manager.users."${user}" = {
          imports = [
            home
            ./modules/home-manager
            inputs.hyprland.homeManagerModules.default
            inputs.catppuccin.homeManagerModules.catppuccin
            inputs.nixvim.homeManagerModules.nixvim
            { nixpkgs.overlays = [ inputs.zig.overlays.default ]; }
          ];
        };
      };
    in {
      nixosConfigurations = {
        nixos = makeNixosSystem [
          ./hosts/nixos
          (makeHomeManager "alpyg" ./home/nixos.nix)
        ];
        t470 = makeNixosSystem [
          ./hosts/t470
          (makeHomeManager "alpyg" ./home/t470.nix)
        ];
        nexus = makeNixosSystem [
          ./hosts/nexus
          (makeHomeManager "nexus" ./home/nexus.nix)
        ];
        kuyin = makeNixosSystem [
          ./hosts/kuyin
          (makeHomeManager "kuyin" ./home/kuyin.nix)
        ];
      };
    };
}
