{
  description = "Nix flake with Geometry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    {
      packages = import ./packages.nix {inherit nixpkgs; };

      defaultPackage = {
        x86_64-linux = self.packages.x86_64-linux;
        aarch64-linux = self.packages.aarch64-linux;
        x86_64-darwin = self.packages.x86_64-darwin;
        aarch64-darwin = self.packages.aarch64-darwin;
      };

      homeModules.default = import ./options.nix;
    };
}
