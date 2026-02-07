{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  glib,
  libcosmicAppHook,
  pkg-config,
  util-linux,
  libgbm,
  pipewire,
  gst_all_1,
  cosmic-wallpapers,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "xdg-desktop-portal-cosmic";
  version = "epoch-1.0.5-unstable-2026-02-06";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "xdg-desktop-portal-cosmic";
    rev = "e11c0f524e2d9307dfd77200f6496246e576d71f";
    hash = "sha256-8oMApAQtG2x12nfr/CGDnp+STmrPYUdZ8XPClvO1xjo=";
  };

  cargoHash = "sha256-99MGWfZrDOav77SRI7c5V21JTfkq7ejC7x+ZiQ5J0Yw=";

  strictDeps = true;

  nativeBuildInputs = [
    libcosmicAppHook
    rustPlatform.bindgenHook
    pkg-config
    util-linux
  ];

  buildInputs = [
    libgbm
    pipewire
  ];

  checkInputs = [ gst_all_1.gstreamer ];

  dontCargoInstall = true;

  makeFlags = [
    "prefix=${placeholder "out"}"
    "CARGO_TARGET_DIR=target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  meta = {
    homepage = "https://github.com/pop-os/xdg-desktop-portal-cosmic";
    description = "XDG Desktop Portal for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    mainProgram = "xdg-desktop-portal-cosmic";
    platforms = lib.platforms.linux;
  };
})
