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
  version = "epoch-1.0.6-unstable-2026-02-12";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-comp";
    rev = "67c08ef692ed8fce882a2a51a446c3da0928d6ef";
    hash = "sha256-mzW0Tu30n4rMZeI5xRRrcq1MmMbgNNsdAFiTNDg2u2g=";
  };

  cargoHash = "sha256-hcQ6u4Aj5Av9T9uX0oDSbJG82g6E8IXcJc4Z2CfoRtg=";

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
