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
  version = "epoch-1.0.1-unstable-2025-12-30";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "98bf8c59876b7865f4e1a95ae0d7025ecda4b020";
    hash = "sha256-8wYX3KCWXHwTb7NHg0wXxmxtVG+jOFU3EidIomPYY0s=";
  };

  cargoHash = "sha256-zyM4iMJs2wPIKIEdji1uJF3WYpPGihFswIK5Wyf6Mns=";

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
