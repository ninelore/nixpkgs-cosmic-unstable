{
  cosmic-store,
  fetchFromGitHub,
}:

cosmic-store.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-store";
    rev = "3b359999d8e93a091cac4c94ec3ffcfa2f7170ee";
    hash = "sha256-Jah/9g0gfMq8y9EHE5pef9SOg5QVq07FfOTZq/G6iAg=";
  };

  cargoHash = "sha256-fHiOTNenEyjdTq6whRbnPI8D7KerkiXWzOYsXZSVHEw=";
})
