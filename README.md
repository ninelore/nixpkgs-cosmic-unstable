# NixOS COSMIC unstable builds

- Nightly automatic updates
- Built by GitHub Actions for aarch64 and x86_64
- Binary cached on https://9lore.cachix.org

## Usage

1. Add this flake as an input to your system flake.
2. Add the default module to your nixosConfiguration. This will add the overlay as well as the binary cache.

Example:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    cosmic-unstable.url = "github:ninelore/nixpkgs-cosmic-unstable";
  };
  outputs =
    inputs@{ ... }: {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        inputs.cosmic-unstable.nixosModules.default
      ];
    };
  };
}
```

## License

This flake is licensed under the [MIT License](LICENSE.md).

Note: MIT license does not apply to the packages built by this flake,
merely to the files in this repository (the Nix expressions, build
scripts, NixOS modules, etc.). It also might not apply to patches
included here, which may be derivative works of the packages to which
they apply. The aforementioned artifacts are all covered by the
licenses of the respective packages.

