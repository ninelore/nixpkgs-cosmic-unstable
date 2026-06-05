{
  cosmic-player,
  fetchFromGitHub,
}:
cosmic-player.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "c33c3e97cdc38667e316c1d15b20b32635f48269";
    hash = "sha256-cilSSYRichqf656TVCZBF098n61bvyboR3bvD7f2/8E=";
  };

  cargoHash = "sha256-JvgqW4B3vc0+dUaxrWnOThCzQDktLZQ/dVG1+A/a6I4=";
})
