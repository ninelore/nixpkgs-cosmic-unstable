{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  just,
  libcosmicAppHook,
  fontconfig,
  freetype,
  libinput,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-term";
  version = "epoch-1.0.1-unstable-2025-12-30";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "a43b5f7d448d12134c04f37fe283f0e9434ea077";
    hash = "sha256-Suq1lSdhEoZHeMAC25xlTEPpXRlB8oByaygZ3Xqq1yg=";
  };

  cargoHash = "sha256-ImWHjEKgu9FQR52A3GjnAkxlPduKuzSUAOANYr0DzMA=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    fontconfig
    freetype
    libinput
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
    homepage = "https://github.com/pop-os/cosmic-term";
    description = "Terminal for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-term";
  };
})
