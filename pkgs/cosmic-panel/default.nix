{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-panel";
  version = "epoch-1.0.11-unstable-2026-03-18";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "d518c7d25ef96f1a9696aa8cce008656bf66ece4";
    hash = "sha256-QbdLYJMe1jxBb5c2LsQXwfURNldkR+WAYq+7fpoXJJU=";
  };

  cargoHash = "sha256-vXmLoyHtHvzy47CZvtCEeyyZrYCc+RciE54OKwqJiBw=";

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

  meta = {
    homepage = "https://github.com/pop-os/cosmic-panel";
    description = "Panel for the COSMIC Desktop Environment";
    mainProgram = "cosmic-panel";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
