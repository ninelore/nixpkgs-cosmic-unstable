{
  cosmic-settings,
  fetchFromGitHub,
}:
cosmic-settings.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-04";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings";
    rev = "5c23ec1b1a879e41731c45561e66abdf03633802";
    hash = "sha256-99DcdwgN4k61wvdJAStQkhdGUA2xyOVkM5UeIZS4Mg0=";
  };

  cargoHash = "sha256-2ZHuOmtBzXQ/KSBMKus9LbojfByYzzCjIkbGY8C85bU=";
})
