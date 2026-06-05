{
  cosmic-store,
  fetchFromGitHub,
}:

cosmic-store.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-store";
    rev = "76df83bb5427eb4a1fe19c126a05d28d8f3ffbca";
    hash = "sha256-Tp5Qiq/Qic5bsH927aauW7GyqGNlPZBC5ruQZEwdaC8=";
  };

  cargoHash = "sha256-fHiOTNenEyjdTq6whRbnPI8D7KerkiXWzOYsXZSVHEw=";
})
