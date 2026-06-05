{
  cosmic-edit,
  fetchFromGitHub,
}:
cosmic-edit.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "bf217ab250d007443145678a14b4aba130f279c2";
    hash = "sha256-R4muqV0zqNd+j89EDeqPkkGq8QRxyZDCcslkdOuLPc0=";
  };

  cargoHash = "sha256-InzFwzGUM4IH8kaULzLboDfwc6U5fcTdN6+sx5SLZJo=";
})
