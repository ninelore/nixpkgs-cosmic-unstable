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
  version = "epoch-1.0.0-beta.9-unstable-2025-12-04";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "62887898421bc9ed2b16987e20f24cb17c5d261f";
    hash = "sha256-oF0ydAVSs+Tt6LCSCe5XZoD6+myQkvB2407k5qtzhr8=";
  };

  cargoHash = "sha256-LZ4Hzwx0PKXm/Mx5VCiQc7xA5cVoYDE93gFWTxP1RDQ=";

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
