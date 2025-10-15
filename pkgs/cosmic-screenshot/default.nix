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
  version = "epoch-1.0.0-beta.1.1-unstable-2025-10-14";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-screenshot";
    rev = "8ca2c6a662ba1b8a8790cd3caf1a0fe28bb85845";
    hash = "sha256-ZvbYb3gkA5cLcIulUQID8lj9USu6EurPUUMEdaGnZak=";
  };

  cargoHash = "sha256-O8fFeg1TkKCg+QbTnNjsH52xln4+ophh/BW/b4zQs9o=";

  nativeBuildInputs = [
    just
    pkg-config
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

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-screenshot";
    description = "Screenshot tool for the COSMIC Desktop Environment";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "cosmic-screenshot";
  };
})
