{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-applibrary";
  version = "epoch-1.0.0-beta.4-unstable-2025-10-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "38d0bc552633516be52d85f4ac4836dcd5d58bae";
    hash = "sha256-n9aKKvWNRnXV1MdqrmRg70deu8llbjKOqAZOjRcfMvQ=";
  };

  cargoHash = "sha256-CX1/6fXL63P1J6yjvFKd91WqSf4+mf+GOtX1O9fHfgg=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
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
    homepage = "https://github.com/pop-os/cosmic-applibrary";
    description = "Application Template for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-app-library";
  };
})
