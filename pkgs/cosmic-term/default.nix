{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  just,
  libcosmicAppHook,
  fontconfig,
  freetype,
  libinput,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-term";
  version = "epoch-1.0.6-unstable-2026-02-12";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "7c59e94308d093414903aa6507107278dca68709";
    hash = "sha256-2Wmicmqoq8Wf6tCU5/oxkV5dAWLQKRzMTASeHAk6YQw=";
  };

  cargoHash = "sha256-uKPRRfjhx1Yc+6hFTjac3333Do92+GFY36DEhw9F91U=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    fontconfig
    freetype
    libinput
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
    homepage = "https://github.com/pop-os/cosmic-term";
    description = "Terminal for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-term";
  };
})
