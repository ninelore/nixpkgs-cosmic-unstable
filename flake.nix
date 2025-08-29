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
        sourceAttrSet = self.packages;
        attrPrefix = "packages";
        lib = inputs.nixpkgs.lib;
      };

      packageList = inputs.nixpkgs.lib.uniqueStrings (
        inputs.nixpkgs.lib.map (x: x.name) self.githubActions.matrix.include
      );

      packages = forSystems (system: import ./pkgs { inherit inputs system; });

      lib = import ./lib;

      overlays.default =
        final: prev:
        import ./pkgs {
          inherit inputs;
          system = prev.system;
        };

      nixosModules.default = {
        nixpkgs.overlays = [
          # (
          #   final: prev:
          #   import ./pkgs {
          #     inherit inputs;
          #     system = prev.system;
          #   }
          # )
          self.overlays.default
        ];
        nix = {
          settings = {
            extra-substituters = [ "https://9lore.cachix.org" ];
            extra-trusted-public-keys = [ "9lore.cachix.org-1:H2/a1Wlm7VJRfJNNvFbxtLQPYswP3KzXwSI5ROgzGII=" ];
          };
        };
      };
    };
}
