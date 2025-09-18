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
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-17";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-workspaces-epoch";
    rev = "85436fa9d6d5156a2f27076c96b6e62b46dcefa5";
    hash = "sha256-sJbaQWUyWSf/33bpFQwLj193sZenKYAgsZzXInAOLKs=";
  };

  cargoHash = "sha256-ICZSp1lE8he+aQN9zjdHF9gGy2KqcVX7xZwtCd8ar6U=";

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
