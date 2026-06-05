{
  cosmic-comp,
  fetchFromGitHub,
}:

cosmic-comp.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "693d1ad775193deb95a33810b5eac59684ca2ac0";
    hash = "sha256-AGr79thSNC81KxegwJAgmfxIzu3MhTa1RBEBjkqFbdM=";
  };

  cargoHash = "sha256-ZtC9hwQ8r7W3j30OI4A2cGHMHOVYVe4XYlnSFnAbvRY=";
})
