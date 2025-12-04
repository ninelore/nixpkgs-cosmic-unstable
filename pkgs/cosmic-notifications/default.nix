{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  libcosmicAppHook,
  which,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-notifications";
  version = "epoch-1.0.0-beta.9-unstable-2025-11-25";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "592c6ace2a49857fa6610bd1a4ad4cfd899e6d68";
    hash = "sha256-2j6F2aYm/tqRlIk0i7HINGI1DuXhI3FX71ggXoPoPpY=";
  };

  cargoHash = "sha256-kLvfZBHJbVSceqKuB9XFshTH4Sl54hKfm8H90RUszKk=";

  nativeBuildInputs = [
    just
    which
    libcosmicAppHook
  ];

  dontUseJustBuild = true;
  # Runs the default checkPhase instead
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
    homepage = "https://github.com/pop-os/cosmic-notifications";
    description = "Notifications for the COSMIC Desktop Environment";
    mainProgram = "cosmic-notifications";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
