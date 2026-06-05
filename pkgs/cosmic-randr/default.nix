{
  cosmic-randr,
  fetchFromGitHub,
}:
cosmic-randr.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-02-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-randr";
    rev = "6e8e795970fa06d434af22775e415b517f7552d3";
    hash = "sha256-Jimw6YCRouG9FDlLBp15OOCRlywBIaP/K/bXLR7trQM=";
  };

  cargoHash = "sha256-QWSPj7bxxWh5/KeNEtUsfDKg+JMONLjomrMcn57j6fw=";
})
