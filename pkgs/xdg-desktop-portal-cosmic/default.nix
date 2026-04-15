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
  version = "epoch-1.0.10-unstable-2026-04-14";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "xdg-desktop-portal-cosmic";
    rev = "08b9ed8f117d36248d22cecf8c3af389f74806d8";
    hash = "sha256-vltoh2n2Tt8TAQdpZDV2woaaacS5Z+o0hDHJfysR4P8=";
  };

  cargoHash = "sha256-eherqBRuIVcs7ZxYfMyiRC4SUIbPzVUcflScoeKrpVA=";

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
