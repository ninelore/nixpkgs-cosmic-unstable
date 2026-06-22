{
  cosmic-settings,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-settings.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-04";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-settings";
      rev = "5c23ec1b1a879e41731c45561e66abdf03633802";
      hash = "sha256-99DcdwgN4k61wvdJAStQkhdGUA2xyOVkM5UeIZS4Mg0=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
