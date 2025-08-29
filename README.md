# NixOS COSMIC nightly builds

Should hopefully update automatically.

## Usage

1. Add this flake as an input to your system flake.
2. Add the default module to your nixosConfiguration. This will add the overlay as well as the binary cache.

## License

This flake is licensed under the [MIT License](LICENSE.md).

Note: MIT license does not apply to the packages built by this flake,
merely to the files in this repository (the Nix expressions, build
scripts, NixOS modules, etc.). It also might not apply to patches
included here, which may be derivative works of the packages to which
they apply. The aforementioned artifacts are all covered by the
licenses of the respective packages.

