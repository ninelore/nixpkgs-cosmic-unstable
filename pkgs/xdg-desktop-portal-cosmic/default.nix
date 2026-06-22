{
  xdg-desktop-portal-cosmic,
  fetchFromGitHub,
  rustPlatform,
}:
xdg-desktop-portal-cosmic.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-19";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "xdg-desktop-portal-cosmic";
      rev = "d26e566b44c89e5527a2b345cfcecb8e23734872";
      hash = "sha256-jppcfnBDyHuRiHZr6Ot6/O4ETgrXe3X5dI5vdzEwlBU=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
