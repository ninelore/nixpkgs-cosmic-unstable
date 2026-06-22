{
  cosmic-player,
  fetchFromGitHub,
}:
cosmic-player.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "c0b1bda86bc4dd86f52c97c55a820493b6273d26";
    hash = "sha256-iDEyR+P+iXShH0YFtqxvPbbs9kgtYvAsuKchB6plnKI=";
  };

  cargoHash = "sha256-JvgqW4B3vc0+dUaxrWnOThCzQDktLZQ/dVG1+A/a6I4=";
})
