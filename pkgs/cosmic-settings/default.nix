{
  cosmic-settings,
  fetchFromGitHub,
}:
cosmic-settings.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-04";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings";
    rev = "fff148587658a1a5caf8ea792ba31c032a2a5440";
    hash = "sha256-reRiR9X6tdpL1rHzpQMkpS9UgM5/GdYMAVCLl4vG2BA=";
  };

  cargoHash = "sha256-2ZHuOmtBzXQ/KSBMKus9LbojfByYzzCjIkbGY8C85bU=";
})
