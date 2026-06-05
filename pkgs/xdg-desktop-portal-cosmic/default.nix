{
  xdg-desktop-portal-cosmic,
  fetchFromGitHub,
}:
xdg-desktop-portal-cosmic.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-19";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "xdg-desktop-portal-cosmic";
    rev = "297e1c66b950ec03a0988a9a170c150df3cac404";
    hash = "sha256-Bo1RKtbwyPc813fjbRrThxKxX2kwbI/iLb+KEGjWF1E=";
  };

  cargoHash = "sha256-/7jxEktXW1+4nFK7ZFUO3oJhmLNuKMwErnqwgjBQiao=";
})
