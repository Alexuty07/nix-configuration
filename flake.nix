{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.primus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/primus
        ./shell
        ./system
        ./desktop
        ./desktop/autologin.nix
        ./desktop/plasma.nix
      ];
    };
  };
}
