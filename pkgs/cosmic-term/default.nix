{
  cosmic-term,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-term.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "cosmic-term";
    version = "epoch-1.0.16-unstable-2026-06-12";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-term";
      rev = "18b4450c0f3fbe3a35ca7ad3230cda7e7091712e";
      hash = "sha256-KACAIHY0cgh3hVigqStoQPQz+UiZgGR3jDF1hV3C/tQ=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
