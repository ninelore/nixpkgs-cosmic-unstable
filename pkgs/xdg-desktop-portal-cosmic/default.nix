{
  xdg-desktop-portal-cosmic,
  fetchFromGitHub,
}:
xdg-desktop-portal-cosmic.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-19";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "xdg-desktop-portal-cosmic";
    rev = "151120e67d532e33e2721319c683a73947be393c";
    hash = "sha256-9ERxmSXOkOo7s/CjT3GEVVku0tb6bclmLLALcYSeYIw=";
  };

  cargoHash = "sha256-/7jxEktXW1+4nFK7ZFUO3oJhmLNuKMwErnqwgjBQiao=";
})
