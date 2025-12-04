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
  version = "epoch-1.0.0-beta.9-unstable-2025-11-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "ff5fb1ac31fd15630f13bfeeb2b62c2935c35c2f";
    hash = "sha256-RSW5oy5lYY15PbZaoxEwLy6g1+I0pOFBNR3pN5HuEqE=";
  };

  cargoHash = "sha256-gLPNX9CEortxDPM9+QYiHlCTPINnoYL1P90HWVPcezY=";

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
