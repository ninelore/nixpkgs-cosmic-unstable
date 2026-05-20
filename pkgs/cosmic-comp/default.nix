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
  version = "0-unstable-2026-05-19";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "61e677e39f7f4bf6e48cc46a68a3f86e96794d2f";
    hash = "sha256-+1oH5O4G3w1LtppFaNsaCWRVolm8Gx2V8/Xq7GGfjtI=";
  };

  cargoHash = "sha256-XdQK0p76zokFluxFM2ezvNBuqW7vqyked/3FGCvTAMo=";

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
