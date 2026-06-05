{
  cosmic-applets,
  fetchFromGitHub,
}:

cosmic-applets.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applets";
    rev = "ba490e76af3f3602d932033ba80e7805c8892340";
    hash = "sha256-jtGR4RURdSfC5HyZfieQkIPL/9rgTuXoipF6xiheV4o=";
  };

  cargoHash = "sha256-tbGuyqdDTsKYpKxeAuachwbPHTPhmb9Sg3qzxHYosjo=";
})
