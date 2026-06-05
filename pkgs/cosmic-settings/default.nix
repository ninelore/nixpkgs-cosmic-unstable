{
  cosmic-settings,
  fetchFromGitHub,
}:
cosmic-settings.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-04";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings";
    rev = "4ae20bc1db36aae10427efde470a039a8d1ab8ba";
    hash = "sha256-8N+UPgTnUjWwGpzUOO9TGZmBfN+78yEG2fTpPDTrH0c=";
  };

  cargoHash = "sha256-2ZHuOmtBzXQ/KSBMKus9LbojfByYzzCjIkbGY8C85bU=";
})
