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
  version = "epoch-1.0.0-beta.9-unstable-2025-12-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "090841802c1f0b0c288dec4186e99bee1c2635da";
    hash = "sha256-b+YHnh5AdoqB1GDXDBPtLh8Us7vKW+S1g8QZG4deh6w=";
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
