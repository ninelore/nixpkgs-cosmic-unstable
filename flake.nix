{
  description = "COSMIC Desktop Environment - unstable git packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    cosmic-manager = {
      url = "github:HeitorAugustoLN/cosmic-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      packages = forSystems (
        system:
        let
          nixpkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          inherit (nixpkgs)
            cosmic-applets
            cosmic-applibrary
            cosmic-bg
            cosmic-comp
            cosmic-ext-applet-clipboard-manager
            cosmic-ext-applet-external-monitor-brightness
            cosmic-edit
            cosmic-ext-calculator
            cosmic-ext-ctl
            cosmic-ext-tweaks
            cosmic-files
            cosmic-greeter
            cosmic-icons
            cosmic-idle
            cosmic-launcher
            cosmic-notifications
            cosmic-osd
            cosmic-panel
            cosmic-player
            cosmic-protocols
            cosmic-randr
            cosmic-screenshot
            cosmic-session
            cosmic-settings
            cosmic-settings-daemon
            cosmic-store
            cosmic-term
            cosmic-wallpapers
            cosmic-workspaces-epoch
            xdg-desktop-portal-cosmic

            # Build for cache
            cosmic-manager
            ;
        }
      );

      lib = import ./lib;

      overlays.default = (import ./pkgs/default.nix inputs);

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
