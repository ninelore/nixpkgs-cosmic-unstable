{
  cosmic-applets,
  fetchFromGitHub,
}:

cosmic-applets.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applets";
    rev = "8981b0b48ec21ac2c93cad56d82b33c6ef705888";
    hash = "sha256-o+rEO+IA337fhpq6TsH+UZEN7kb/PqydlKo77NyCRcM=";
  };

  cargoHash = "sha256-tbGuyqdDTsKYpKxeAuachwbPHTPhmb9Sg3qzxHYosjo=";
})
