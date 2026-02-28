{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  pkg-config,
  just,
  glib,
  flatpak,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-store";
  version = "epoch-1.0.8-unstable-2026-02-27";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-store";
    rev = "d9a8b6fc68e72c5b38e461d26ef0f9b97f409456";
    hash = "sha256-UnPiKnQEI5erELzzq1V1++6egYJCJMIUDEpKmNdRbQ8=";
  };

  cargoHash = "sha256-5ak3jbGD4TUiJCKn4FCkOvkZK2LzZAlU0zvqp1q1BaY=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    glib
    flatpak
    openssl
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
    homepage = "https://github.com/pop-os/cosmic-store";
    description = "App Store for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
