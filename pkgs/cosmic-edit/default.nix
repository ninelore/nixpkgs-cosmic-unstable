{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  cosmic-icons,
  just,
  pkg-config,
  libcosmicAppHook,
  libinput,
  fontconfig,
  freetype,
  glib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-edit";
  version = "epoch-1.0.16-unstable-2026-06-17";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "b6627523f95f06b6c5c444f8048ede00b3914d29";
    hash = "sha256-Un/j9J7nxnBfrt5HI416fbhywt707PXWY0gB7voemls=";
  };

  cargoHash = "sha256-/qcpAR2nvC/MYa5QuCLiZFQgos5SlYtspZsNuMLJFHk=";

  postPatch = ''
    substituteInPlace justfile --replace-fail '#!/usr/bin/env' "#!$(command -v env)"
  '';

  nativeBuildInputs = [
    libcosmicAppHook
    just
    pkg-config
  ];
  buildInputs = [
    glib
    libinput
    fontconfig
    freetype
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

  postInstall = ''
    wrapProgram "$out/bin/cosmic-edit" \
      --suffix XDG_DATA_DIRS : "${cosmic-icons}/share"
  '';

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-edit";
    description = "Text Editor for the COSMIC Desktop Environment";
    mainProgram = "cosmic-edit";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
})
