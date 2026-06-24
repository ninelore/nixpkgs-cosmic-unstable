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
  version = "epoch-1.1.0-unstable-2026-06-23";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-files";
    rev = "c653b69c75f735c1559e5f8aa621977e81d8373c";
    hash = "sha256-cRwZrmm/zOIV6VCyz2dTH+qn8h6LOnaOiHU5nENTK6o=";
  };

  cargoHash = "sha256-+21DCCTkNrbdxgxQi0YyuAxpl1IvwUz3ccUE+E0sZ4Y=";

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
