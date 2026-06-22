{
  cosmic-settings-daemon,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-settings-daemon.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-13";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-settings-daemon";
      rev = "75c0480f1315ec96ec3eb216fc939f93f57d7612";
      hash = "sha256-6MLZpGGvE1EnUlRv2T6+iXy8B0aqBTNNrqDtBbeABYs=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
