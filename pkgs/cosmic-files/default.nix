{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  libcosmicAppHook,
  glib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-files";
  version = "epoch-1.0.0-unstable-2025-12-11";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-files";
    rev = "a760a9e8d61f037dd7a78ce7d21e1bb29ef91e8a";
    hash = "sha256-cEqDb8De4t4nDnqNGPggJJgt6ILF1qa/Mmvd/2ThxvA=";
  };

  cargoHash = "sha256-Dz8jKqfm/VgvCmEpNXice+M7mwd5Q2XyCl5vl7p6nWI=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  buildInputs = [ glib ];

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

  # This is needed since by setting cargoBuildFlags, it would build both the applet and the main binary
  # at the same time, which would cause problems with the desktop items applet
  buildPhase = ''
    runHook preBuild

    defaultCargoBuildFlags="$cargoBuildFlags"

    cargoBuildFlags="$defaultCargoBuildFlags --package cosmic-files"
    runHook cargoBuildHook

    cargoBuildFlags="$defaultCargoBuildFlags --package cosmic-files-applet"
    runHook cargoBuildHook

    runHook postBuild
  '';

  checkPhase = ''
    runHook preCheck

    cargoTestFlags="$defaultCargoTestFlags --package cosmic-files"
    runHook cargoCheckHook

    cargoTestFlags="$defaultCargoTestFlags --package cosmic-files-applet"
    runHook cargoCheckHook

    runHook postCheck
  '';

  meta = {
    homepage = "https://github.com/pop-os/cosmic-files";
    description = "File Manager for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-files";
    platforms = lib.platforms.linux;
  };
})
