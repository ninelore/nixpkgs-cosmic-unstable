{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  pkg-config,
  wayland,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-randr";
  version = "epoch-1.0.0-beta.9-unstable-2025-11-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-randr";
    rev = "c39fe3fe3573c34ebbdf6d6d7f93ff232800c588";
    hash = "sha256-g5s4TIk8nS3qPIAlWQC4D5A936+DYMbEEnU6v8iO9TI=";
  };

  cargoHash = "sha256-ZStjzRqgCnRy1v2K1upUbioedmDaa1ml1gRNZc32Q00=";

  nativeBuildInputs = [
    just
    pkg-config
  ];

  buildInputs = [ wayland ];

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
    homepage = "https://github.com/pop-os/cosmic-randr";
    description = "Library and utility for displaying and configuring Wayland outputs";
    license = lib.licenses.mpl20;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-randr";
  };
})
