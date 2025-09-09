{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  makeBinaryWrapper,
  cosmic-icons,
  just,
  pkg-config,
  libcosmicAppHook,
  libglvnd,
  libxkbcommon,
  libinput,
  fontconfig,
  freetype,
  libgbm,
  wayland,
  xorg,
  vulkan-loader,
  glib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-edit";
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-07";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "7d11d672905da41fc29f5dcc2f9ef1d002db45bc";
    hash = "sha256-4C+04rI0Y9j59GuZXtwuWYpgtV/7ZTsmp9SWMLENzs4=";
  };

  cargoHash = "sha256-DoAPF06Jf2dQCEUPPYPHQSJ9UIBdMoogS/A/n8JyzRM=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  postPatch = ''
    substituteInPlace justfile --replace-fail '#!/usr/bin/env' "#!$(command -v env)"
  '';

  nativeBuildInputs = [
    libcosmicAppHook
    just
    pkg-config
    makeBinaryWrapper
  ];
  buildInputs = [
    libxkbcommon
    xorg.libX11
    libinput
    libglvnd
    fontconfig
    freetype
    libgbm
    wayland
    vulkan-loader
    glib
  ];

  dontUseJustBuild = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-edit"
  ];

  # Force linking to libEGL, which is always dlopen()ed, and to
  # libwayland-client, which is always dlopen()ed except by the
  # obscure winit backend.
  RUSTFLAGS = map (a: "-C link-arg=${a}") [
    "-Wl,--push-state,--no-as-needed"
    "-lEGL"
    "-lwayland-client"
    "-Wl,--pop-state"
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
