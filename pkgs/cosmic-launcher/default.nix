{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  libcosmicAppHook,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-launcher";
  version = "epoch-1.0.4-unstable-2026-01-31";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "8efac6e982bafc19b98dbe4e46c99cba761d445b";
    hash = "sha256-3l3Cq5cXXJsbthag+LMsKGYM9oyhIAtdfxtUlbl9IrI=";
  };

  cargoHash = "sha256-ImNdFRPDtq3rSqEpBCFOHKKFDCyY9yifNo0nWV2eXmk=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "cargo-target-dir"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  env."CARGO_TARGET_${stdenv.hostPlatform.rust.cargoEnvVarTarget}_RUSTFLAGS" = "--cfg tokio_unstable";

  meta = {
    homepage = "https://github.com/pop-os/cosmic-launcher";
    description = "Launcher for the COSMIC Desktop Environment";
    mainProgram = "cosmic-launcher";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
