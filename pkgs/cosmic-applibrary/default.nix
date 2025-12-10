{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-applibrary";
  version = "epoch-1.0.0-beta.9-unstable-2025-12-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "d06546837b53adf9a02c4b771cb8211738462e37";
    hash = "sha256-A3OWgTgNeuNqMN4WBVJcAXogL9jHABDRIsN0QjgcPDY=";
  };

  cargoHash = "sha256-M3zyBsNFUQ5dwzJRlaC8m6o5U4teIgwl6jTDYSqW8qw=";

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
    homepage = "https://github.com/pop-os/cosmic-applibrary";
    description = "Application Template for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-app-library";
  };
})
