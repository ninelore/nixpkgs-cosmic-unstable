{
  cosmic-osd,
  fetchFromGitHub,
}:
cosmic-osd.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "ce431b4d710a198b13298c96d22fe5ccaadb1943";
    hash = "sha256-18QURT3L1RloFqsr9PR5Ts7YtbhmkCJU4w7E5d/OJIA=";
  };

  cargoHash = "sha256-BngWy8fSfmQYSLV+/3jBvDdI0lpTwqGUiwwHvDlqySw=";
})
