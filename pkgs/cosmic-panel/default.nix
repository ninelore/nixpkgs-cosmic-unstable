{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-panel";
  version = "epoch-1.0.0-beta.1.1-unstable-2025-09-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "0011d82f5b33ae49b42733ce468b86771db7bff6";
    hash = "sha256-9T4Ao0GEzLsHmKA+KVmB8dzhcOhC4P05Ppg1AwAEi+I=";
  };

  cargoHash = "sha256-8KOl581VmsfE7jiVFXy3ZDIfAqnaJuiDd7paqiFI/mk=";

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
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-panel"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-panel";
    description = "Panel for the COSMIC Desktop Environment";
    mainProgram = "cosmic-panel";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
