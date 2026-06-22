{
  cosmic-edit,
  fetchFromGitHub,
}:
cosmic-edit.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "b6627523f95f06b6c5c444f8048ede00b3914d29";
    hash = "sha256-Un/j9J7nxnBfrt5HI416fbhywt707PXWY0gB7voemls=";
  };

  cargoHash = "sha256-InzFwzGUM4IH8kaULzLboDfwc6U5fcTdN6+sx5SLZJo=";
})
