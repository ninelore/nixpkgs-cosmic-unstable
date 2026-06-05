{
  cosmic-files,
  fetchFromGitHub,
}:
cosmic-files.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-files";
    rev = "b1fbc1d5382c6f965a1355053e59fdc6d9d9d3e5";
    hash = "sha256-3NEP4hIz6KdO/nWNZhsE7DMflNr2uwM5R1ja+6H6rzA=";
  };

  cargoHash = "sha256-WOhWgd1fFdlc7o1YtJJnpsHXxwtCQWV1MWmbDsAqxNg=";
})
