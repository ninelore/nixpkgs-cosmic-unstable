{
  description = "COSMIC Desktop Environment - unstable git packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, ... }:
    let
      forSystems = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      formatter = forSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      githubActions = self.lib.mkGithubMatrix {
        sourceAttrSet = self.legacyPackages;
        attrPrefix = "legacyPackages";
        lib = inputs.nixpkgs.lib;
      };

      packages = forSystems (system: import ./pkgs { inherit inputs system; });

      lib = import ./lib;

      overlays.default =
        final: prev:
        import ./pkgs {
          inherit inputs;
          system = prev.system;
        };
    };
}
