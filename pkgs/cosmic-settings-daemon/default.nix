{
  cosmic-settings-daemon,
  fetchFromGitHub,
}:
cosmic-settings-daemon.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "75c0480f1315ec96ec3eb216fc939f93f57d7612";
    hash = "sha256-6MLZpGGvE1EnUlRv2T6+iXy8B0aqBTNNrqDtBbeABYs=";
  };

  cargoHash = "sha256-bz+JasI3WE30sKKgjofVO/42Ml4YY9Dw3JxnZmZVQk4=";
})
