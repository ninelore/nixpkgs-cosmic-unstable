{
  cosmic-panel,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-panel.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-27";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-panel";
      rev = "cf32cd50fbccf60257aea7d9e3f3c81ed99b0a90";
      hash = "sha256-CpeN+Myu1mRlUhpNMwve9XXxMdRkPAFvbsES2JO4TqY=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
