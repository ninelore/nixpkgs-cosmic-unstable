{
  cosmic-initial-setup,
  fetchFromGitHub,
}:
cosmic-initial-setup.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-initial-setup";
    rev = "b209a8d460d23a3a202e19a3de95027e9f4a61d8";
    hash = "sha256-bTy/e60nInZCKulsNm9QmgeT6eSLRRCv0D+yP3oTQ1U=";
  };

  cargoHash = "sha256-DESnl5NjakU4++Ep6CHxDZzHn+o0Gi0eREpXk5BN5iY=";
})
