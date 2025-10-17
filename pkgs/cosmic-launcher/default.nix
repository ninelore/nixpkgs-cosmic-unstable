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
  version = "epoch-1.0.0-beta.2-unstable-2025-10-16";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "5ad1bfbceecd8a0940c3fa8e1d9696c6606e5cb1";
    hash = "sha256-lvbLCdZFmI1kCrHf9FANWSNkfDBUAzqlTiITk3I7bMo=";
  };

  cargoHash = "sha256-bW6XtdK+AZiuwfzBUWmUi00RJXeuzgzGKoL35lyDBfM=";

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
