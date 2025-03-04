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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig.url = "github:Alpyg/zig-overlay";
  };

  outputs = { self, nixpkgs, catppuccin, nixvim, nvf, ... }@inputs:
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

      makeHomeManager = user: home: {
        home-manager.users."${user}" = {
          imports = [
            home
            ./modules/home-manager
            catppuccin.homeManagerModules.catppuccin
            nixvim.homeManagerModules.nixvim
            nvf.homeManagerModules.default
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
