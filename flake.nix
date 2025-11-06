{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    catppuccin.url = "github:catppuccin/nix";
    nixvim.url = "github:Alpyg/nixvim";
    zig.url = "github:Alpyg/zig-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    inherit (import nixpkgs {inherit system;}) lib;

    makeNixosSystem = modules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};

        modules =
          [
            ./modules/nixos
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            inputs.catppuccin.nixosModules.catppuccin
          ]
          ++ modules;
      };

    makeHomeManager = user: home: {
      home-manager = {
        extraSpecialArgs = {inherit inputs;};
        backupFileExtension = "bak";
        users."${user}" = {
          imports = [
            home
            ./modules/home-manager
            inputs.catppuccin.homeModules.catppuccin
            {nixpkgs.overlays = [inputs.zig.overlays.default];}
          ];
        };
      };
    };
  in {
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
