{
  cosmic-osd,
  fetchFromGitHub,
}:
cosmic-osd.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "28af81d1a7479b4e9edddb2fcf8c93f2074bad6b";
    hash = "sha256-jv28hxhQUcUDLnOwU3xQJwCU+s52pwDNs8Gf4I5Hp9k=";
  };

  cargoHash = "sha256-BngWy8fSfmQYSLV+/3jBvDdI0lpTwqGUiwwHvDlqySw=";
})
