{
  cosmic-screenshot,
  fetchFromGitHub,
}:

cosmic-screenshot.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-01";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-screenshot";
    rev = "d6ef210e981d045fec5022416b85edd0afc03e16";
    hash = "sha256-RYvc/3FoRnNkuYBVfCG75Bmfb8JWW1H4GKXyhq7CxaQ=";
  };

  cargoHash = "sha256-q0RJST1yeqPBjU5MseNZIrZw+brfDtQLKiw7wyViflE=";
})
