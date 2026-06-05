{
  cosmic-initial-setup,
  fetchFromGitHub,
}:
cosmic-initial-setup.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-initial-setup";
    rev = "8eabeaf64804dd74ef2da7803b42f21ed1b498e2";
    hash = "sha256-3nGPBWYDqPJN99WtzsAVERucwiVAFynuUk2gezZ/RJU=";
  };

  cargoHash = "sha256-DESnl5NjakU4++Ep6CHxDZzHn+o0Gi0eREpXk5BN5iY=";
})
