{
  cosmic-bg,
  fetchFromGitHub,
  rustPlatform,
}:

cosmic-bg.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-04-30";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-bg";
      rev = "b1ca4c180ab29dd185472b777ab0abdb1f96ccaf";
      hash = "sha256-E4OWxoGyRNFcMl7ni7PB6PE0Yl7dE+Wd4JGDMHO94Yw=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
