{
  description = "COSMIC Desktop Environment - unstable git packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";

  outputs =
    inputs@{ self, ... }:
    let
      forSystems = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
      pkgList = [
        "cosmic-applets"
        "cosmic-applibrary"
        "cosmic-bg"
        "cosmic-comp"
        "cosmic-ext-applet-clipboard-manager"
        "cosmic-edit"
        "cosmic-ext-tweaks"
        "cosmic-files"
        "cosmic-greeter"
        "cosmic-icons"
        "cosmic-idle"
        "cosmic-initial-setup"
        "cosmic-launcher"
        "cosmic-notifications"
        "cosmic-osd"
        "cosmic-panel"
        "cosmic-player"
        "cosmic-protocols"
        "cosmic-randr"
        "cosmic-reader"
        "cosmic-screenshot"
        "cosmic-session"
        "cosmic-settings"
        "cosmic-settings-daemon"
        "cosmic-store"
        "cosmic-term"
        "cosmic-wallpapers"
        "cosmic-workspaces-epoch"
        "xdg-desktop-portal-cosmic"
      ];
    in
    {
      formatter = forSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree);

      githubActions = self.lib.mkGithubMatrix {
        sourceAttrSet = self.packages;
        attrPrefix = "packages";
        inherit (inputs.nixpkgs) lib;
      };

      packageList = inputs.nixpkgs.lib.uniqueStrings (
        inputs.nixpkgs.lib.map (x: x.name) self.githubActions.matrix.include
      );

      packages = forSystems (
        system:
        builtins.listToAttrs (
          map (pkg: {
            name = pkg;
            value = (import inputs.nixpkgs { inherit system; }).callPackage ./pkgs/${pkg} { };
          }) pkgList
        )
      );

      lib = import ./lib;

      overlays.default =
        final: prev:
        builtins.listToAttrs (
          map (pkg: {
            name = pkg;
            value = prev.callPackage ./pkgs/${pkg} { };
          }) pkgList
        );

      nixosModules =
        let
          substituter = {
            nix = {
              settings = {
                extra-substituters = [ "https://9lore.cachix.org" ];
                extra-trusted-public-keys = [ "9lore.cachix.org-1:H2/a1Wlm7VJRfJNNvFbxtLQPYswP3KzXwSI5ROgzGII=" ];
              };
            };
          };
        in
        {
          inherit substituter;
          default = substituter // {
            nixpkgs.overlays = [
              self.overlays.default
            ];
          };
        };
    };
}
