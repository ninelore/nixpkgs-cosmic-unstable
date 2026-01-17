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
  version = "epoch-1.0.2-unstable-2026-01-16";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "f1923f5b9991f747c5341407cbc65087d7feb42d";
    hash = "sha256-4+GfIAsjzo1jr+wa9JjuIUvW3P3r03avP2W5hZJYXHU=";
  };

  cargoHash = "sha256-ydI/DTbGlgwc9l/XsW1SbTOfSyTdcjM0i0jXLua4+f8=";

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
