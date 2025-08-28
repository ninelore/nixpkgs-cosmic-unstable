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
  version = "999";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "af73ac840b72cfe760c4b6e3747fc19d611367e1";
    hash = "sha256-QcrkfU6HNZ2tWfKsMdcv58HC/PE7b4T14AIep85TWOY=";
  };

  cargoHash = "sha256-qufOJeWPRjj4GgWNJmQfYaGKeYOQbkTeFzrUSi9QNnQ=";

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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-panel"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-panel";
    description = "Panel for the COSMIC Desktop Environment";
    mainProgram = "cosmic-panel";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
