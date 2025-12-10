{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  pkg-config,
  libinput,
  libgbm,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-workspaces-epoch";
  version = "epoch-1.0.0-beta.9-unstable-2025-12-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-workspaces-epoch";
    rev = "954a45ca4c06c7292a6c2faaf63036db07ca0536";
    hash = "sha256-qqnZAQp8SweVMe59m02xe27qw4S7ypraASgV8lCWB2I=";
  };

  cargoHash = "sha256-ZVl09YgeH+V4X3H88rdeiBgua1IpVcfKe0y8A78wzl4=";

  nativeBuildInputs = [
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    libinput
    libgbm
    udev
  ];

  dontCargoInstall = true;

  makeFlags = [
    "prefix=${placeholder "out"}"
    "CARGO_TARGET_DIR=target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-workspaces-epoch";
    description = "Workspaces Epoch for the COSMIC Desktop Environment";
    mainProgram = "cosmic-workspaces";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
