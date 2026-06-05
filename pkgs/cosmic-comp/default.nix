{
  cosmic-comp,
  fetchFromGitHub,
}:

cosmic-comp.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "2f7c34f29ae8d1d5b7d147bdb69ae443bd630e98";
    hash = "sha256-x0g1+3urCHqbLhFYmyncH6SU1wXVkEioRdcUR/z+SRI=";
  };

  cargoHash = "sha256-ZtC9hwQ8r7W3j30OI4A2cGHMHOVYVe4XYlnSFnAbvRY=";
})
