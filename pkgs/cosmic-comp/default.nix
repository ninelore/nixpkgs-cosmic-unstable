{
  cosmic-comp,
  fetchFromGitHub,
  rustPlatform,
}:

cosmic-comp.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-03";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-comp";
      rev = "aac1e19f08a016ade349569fbf8c0305761de20b";
      hash = "sha256-fUuw7qwfojAmu/mkWMkWBhpcSgZNTIzdXmInjyKrZBI=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
