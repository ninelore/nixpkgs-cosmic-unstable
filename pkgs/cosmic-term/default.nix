{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  just,
  libcosmicAppHook,
  fontconfig,
  freetype,
  libinput,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-term";
  version = "epoch-1.0.14-unstable-2026-05-28";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "91fd140ae371498bd2cd3fa86e5a9acd02a02f16";
    hash = "sha256-Q5SFV+avNMX0/n5fOKpZIZmBCatv/dNzTLFLBMQfnJ8=";
  };

  cargoHash = "sha256-dDvUa+NEc5DL8WNDcd5rv8bEdMUvsZn3eTY52mAmwa8=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    fontconfig
    freetype
    libinput
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

  meta = {
    homepage = "https://github.com/pop-os/cosmic-term";
    description = "Terminal for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-term";
  };
})
