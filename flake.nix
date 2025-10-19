{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }: {
    nixosConfigurations = {
      ThinkpadP16s = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p16s-amd-gen2
          ./graphical.nix
          home-manager.nixosModules.home-manager
          ./tudoan
          ./ThinkpadP16s
        ];
      };
    };
  };
}
