{
  description = "Project Yggdrasil, flake for my systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      fenrir = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/fenrir/configuration.nix
          home-manager.nixosModules.home-manager
          {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.wyatt = ./hosts/fenrir/home.nix;
          #   backupFileExtension = ".bak";
          };
          }
        ];
        # home-manager.users.wyatt.imports = [ (import ./hosts/fenrir/home.nix) ];
      };
      jormungandr = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/jormungandr/configuration.nix
        ];
      };
    };
  };
}
