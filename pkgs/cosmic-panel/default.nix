{
  cosmic-panel,
  fetchFromGitHub,
}:

cosmic-panel.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-27";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "546a6c45210574caed9a3e51446aa8ad622d3627";
    hash = "sha256-uAg9zT4tFTlFiPHqI8cVS/kc2ZAm+3t3QPrHTU8LzFY=";
  };

  cargoHash = "sha256-6E+bAi1f6gOZh64wyvLMKZiZNlMexPV+ZzS3riOx9xM=";
})
