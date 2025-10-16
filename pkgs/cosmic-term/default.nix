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
  version = "epoch-1.0.0-beta.2-unstable-2025-10-14";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "8c409f5be3cf8e35065b5522915dfe0827d1b112";
    hash = "sha256-Gf5C135I3MBxyYBvgbOcY4USa75BeD7sPhFjq5BIM1s=";
  };

  cargoHash = "sha256-qXAgmVsjhr3aqEQRGjsK2JM8YwpkRK5Y+XYJRSZ8Swc=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

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
