{
  description = "Alpyg nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:nix-community/stylix";
    nixcord.url = "github:kaylorben/nixcord";
    nixvim.url = "/mnt/x/Dev/nixvim";
    zig.url = "github:Alpyg/zig-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      inherit (import nixpkgs { inherit system; }) lib;

      makeNixosSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./modules/nixos
            inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
            inputs.home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops
            inputs.stylix.nixosModules.stylix
          ]
          ++ modules;
        };

      makeHomeManager = user: home: {
        home-manager = {
          extraSpecialArgs = { inherit inputs; };
          backupFileExtension = "bak";
          users."${user}" = {
            imports = [
              home
              ./modules/home-manager
              inputs.stylix.homeModules.stylix
              inputs.nixcord.homeModules.nixcord
              { nixpkgs.overlays = [ inputs.zig.overlays.default ]; }
            ];
          };
        };
      };
    in
    {
      nixosConfigurations = {
        nixos = makeNixosSystem [
          ./hosts/nixos
          (makeHomeManager "alpyg" ./home/nixos.nix)
        ];
        kuyin = makeNixosSystem [
          ./hosts/kuyin
          (makeHomeManager "kuyin" ./home/kuyin.nix)
        ];
        t470 = makeNixosSystem [
          ./hosts/t470
          (makeHomeManager "alpyg" ./home/t470.nix)
        ];

        nexus = makeNixosSystem [
          ./hosts/nexus
          (makeHomeManager "nexus" ./home/nexus.nix)
        ];
        nas = makeNixosSystem [
          ./hosts/nas
          (makeHomeManager "nas" ./home/nas.nix)
        ];

        live = makeNixosSystem [
          ./hosts/live
        ];
      };
    };
}
