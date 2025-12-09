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
  version = "epoch-1.0.0-beta.9-unstable-2025-12-08";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-workspaces-epoch";
    rev = "a607da7f4479d857a45503b84ae4920698fe27b0";
    hash = "sha256-gka/6YhBFvvFmhfCd8tA8GMmGWdEtii9lLmZNLXaz28=";
  };

  cargoHash = "sha256-qvL2NkLwE6t5XqvLwvU8hbzGuOQSzR5MssEYLAI5YD8=";

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
