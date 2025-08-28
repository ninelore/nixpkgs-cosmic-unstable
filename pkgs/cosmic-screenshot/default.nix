{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  pkg-config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-screenshot";
  version = "999";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-screenshot";
    rev = "1747b8a53eb3d6a3b72c90f4247e462da6289ffa";
    hash = "sha256-VvU/9vYdoTvy3yzdeXrhKrtS9tUHMKnaSAeNTEKk5PA=";
  };

  cargoHash = "sha256-1r0Uwcf4kpHCgWqrUYZELsVXGDzbtbmu/WFeX53fBiQ=";

  nativeBuildInputs = [
    just
    pkg-config
  ];

  dontUseJustBuild = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-screenshot"
  ];

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-screenshot";
    description = "Screenshot tool for the COSMIC Desktop Environment";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "cosmic-screenshot";
  };
})
