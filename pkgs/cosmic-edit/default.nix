{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  cosmic-icons,
  just,
  pkg-config,
  libcosmicAppHook,
  libglvnd,
  libinput,
  fontconfig,
  freetype,
  glib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-edit";
  version = "epoch-1.0.0-beta.4-unstable-2025-10-30";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "113a4387595d0cdd8a9de6b77ddf49071ff72a7c";
    hash = "sha256-mhCD0Ya7BsYlG3Zicm61R7BByY0FHEVSGh9yKLLAPFI=";
  };

  cargoHash = "sha256-Ot69WdCvdT8xg3/LPMb8C5Rdq04Mvmr5VLS+adnvuvY=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

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
    libglvnd
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
