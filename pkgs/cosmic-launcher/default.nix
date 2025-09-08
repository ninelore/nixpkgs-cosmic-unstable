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
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-07";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "e2aa2aaa0be8bd6269d2e08ec56aee43c0638bec";
    hash = "sha256-i2kKtvE/8SnSZWrzT3eMcmNIjEA1SZIvdJxsPKKSCrY=";
  };

  cargoHash = "sha256-57rkCufJPWm844/iMIfULfaGR9770q8VgZgnqCM57Zg=";

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
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-launcher"
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
