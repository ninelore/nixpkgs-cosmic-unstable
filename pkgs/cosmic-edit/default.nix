{
  cosmic-edit,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-edit.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-02";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-edit";
      rev = "b6627523f95f06b6c5c444f8048ede00b3914d29";
      hash = "sha256-Un/j9J7nxnBfrt5HI416fbhywt707PXWY0gB7voemls=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
