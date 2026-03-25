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
  version = "epoch-1.0.8-unstable-2026-03-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "582c49934fab1546a94271ac9ec5ecfdea07cb36";
    hash = "sha256-fn9Yqnt714KDWkmJI0TDcH/NGTPEO8wU5xrqfr0OxmM=";
  };

  cargoHash = "sha256-4GBzyHYdTUInsl58/CrbVq+eTV5S8Q1kRG5zQFA6TaQ=";

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
