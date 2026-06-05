{
  cosmic-player,
  fetchFromGitHub,
}:
cosmic-player.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "2c1ace71703cbc434b38017a99ffb2bf668f9df9";
    hash = "sha256-p03lQP9859T2r8hYduzHJAom2LYtaNzHgcHk79o6Yyw=";
  };

  cargoHash = "sha256-JvgqW4B3vc0+dUaxrWnOThCzQDktLZQ/dVG1+A/a6I4=";
})
