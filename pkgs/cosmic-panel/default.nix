{
  cosmic-panel,
  fetchFromGitHub,
}:

cosmic-panel.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-27";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "029400b2b447d9d31f1a772d7f6f0d5eed2ea21e";
    hash = "sha256-GvPHhoRxGIUACIIDGQKJkEbK76uBcDr/NLsLshlkM+A=";
  };

  cargoHash = "sha256-6E+bAi1f6gOZh64wyvLMKZiZNlMexPV+ZzS3riOx9xM=";
})
