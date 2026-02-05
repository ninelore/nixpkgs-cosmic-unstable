{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  pkg-config,
  libdisplay-info,
  libgbm,
  libinput,
  pixman,
  seatd,
  udev,
  systemd,

  useSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-comp";
  version = "epoch-1.0.5-unstable-2026-02-05";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "8e9f832fad93f3e8b0a07c0c518daeaf325ac9fc";
    hash = "sha256-eMepE0hd7GmiF0WyebqZT3kx9vzp5rLeykRIcaaiYcU=";
  };

  cargoHash = "sha256-58qUzJDzwwMB5hmOl9XHmbTRZE/ep5fWKPj5u2onvRM=";

  nativeBuildInputs = [
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
    libdisplay-info
    libgbm
    libinput
    pixman
    seatd
    udev
  ]
  ++ lib.optional useSystemd systemd;

  # Only default feature is systemd
  buildNoDefaultFeatures = !useSystemd;

  makeFlags = [
    "prefix=${placeholder "out"}"
    "CARGO_TARGET_DIR=target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  dontCargoInstall = true;

  meta = {
    homepage = "https://github.com/pop-os/cosmic-comp";
    description = "Compositor for the COSMIC Desktop Environment";
    mainProgram = "cosmic-comp";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
