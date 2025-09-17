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
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-16";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "140e6aab885b7680dc042d86ea62f8fb5c4838c2";
    hash = "sha256-zXYgfUzxz21tj/C4GWb5/V8mnxU/HmgPcEvLhny2pKw=";
  };

  cargoHash = "sha256-YfD06RAQPZRwapd0fhNsZ0tx+0JMNDXiPJIWwDhmG0M=";

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
