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
  version = "epoch-1.2.0-unstable-2026-07-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "7c723b7705ec77b1ad5396a1baa9ae1c0cb5a0da";
    hash = "sha256-6Po/6VK1n8inpiMEESKwBHE0XL692XZj3w/R8evvh4I=";
  };

  cargoHash = "sha256-32AoA17CO4noUzKhx+KDBpy5fWG4lvSBMK5aVJW8K9o=";

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
