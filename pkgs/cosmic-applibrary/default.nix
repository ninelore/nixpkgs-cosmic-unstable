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
  version = "epoch-1.0.7-unstable-2026-02-18";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "900edfb484d807aa5a7f54553d014827338314c8";
    hash = "sha256-MkAjfB1VVJ3gM6qwZ/bsNeuiL+cSbuS3fr+uW9bMp40=";
  };

  cargoHash = "sha256-h/LjcSKnmZof4/OFyLDUFWcjn6TiTt8eRAJkj8lUC0Y=";

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
