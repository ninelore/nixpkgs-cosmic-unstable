{
  cosmic-store,
  fetchFromGitHub,
}:

cosmic-store.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-store";
    rev = "211987df1827e0babfe62474da0c3ee38fe6aac8";
    hash = "sha256-JE8LcFlhG4e3QqobzUNfCw3Eg10+FrlVuQu+J+96/es=";
  };

  cargoHash = "sha256-fHiOTNenEyjdTq6whRbnPI8D7KerkiXWzOYsXZSVHEw=";
})
