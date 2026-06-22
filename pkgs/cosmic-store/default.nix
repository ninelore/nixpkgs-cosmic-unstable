{
  cosmic-store,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-store.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-02";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-store";
      rev = "211987df1827e0babfe62474da0c3ee38fe6aac8";
      hash = "sha256-JE8LcFlhG4e3QqobzUNfCw3Eg10+FrlVuQu+J+96/es=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
