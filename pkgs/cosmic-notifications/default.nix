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
  version = "epoch-1.0.2-unstable-2026-01-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "d4918c3aef0eced4238231d785cdaf0845fdd497";
    hash = "sha256-lvqqeY/FPv+LFTmZoBUuKWCjAGZozGj/yUCphlFuk/g=";
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
