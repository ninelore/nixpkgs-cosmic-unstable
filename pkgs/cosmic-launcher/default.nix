{
  cosmic-launcher,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-launcher.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "cosmic-launcher";
    version = "epoch-1.0.16-unstable-2026-06-08";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-launcher";
      rev = "a64ed9a29cad0d5b7d2282b6971e95ad3d0b1f62";
      hash = "sha256-ZivzjufT2UlPi/En1AjGS8TfeFNdJDfDUd9cb2Begb8=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
