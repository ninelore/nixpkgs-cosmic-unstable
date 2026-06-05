{
  cosmic-session,
  fetchFromGitHub,
}:

cosmic-session.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-07";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-session";
    rev = "b5ef6c0c0d68762b2991e4f5906cc70599e2f1fc";
    hash = "sha256-lL8is6WveKxOn/Ej3SrMfLrulnb+Qw9QAPcCbdLo07E=";
  };

  cargoHash = "sha256-5dLG40X+yxJo566guyHqOCLNp+uNSE+HONS8GIDm58A=";
})
