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
  version = "epoch-1.0.0-beta.7-unstable-2025-11-21";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "799110541ac9e259e10070abc36ae24498bed4ff";
    hash = "sha256-gyHAhQqUdFOW31YFES59gSpkVcj1JYPExFbxP0IQRmA=";
  };

  cargoHash = "sha256-6b6m6mZTa3Li74JCm6czR0VBc7H5IRTPr7yic3V1FL4=";

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
