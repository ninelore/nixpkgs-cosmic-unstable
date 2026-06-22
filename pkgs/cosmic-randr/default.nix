{
  cosmic-randr,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-randr.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-02-13";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-randr";
      rev = "6e8e795970fa06d434af22775e415b517f7552d3";
      hash = "sha256-Jimw6YCRouG9FDlLBp15OOCRlywBIaP/K/bXLR7trQM=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
