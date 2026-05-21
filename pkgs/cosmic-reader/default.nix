{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  just,
  libcosmicAppHook,
  fontconfig,
  freetype,
  gumbo,
  harfbuzz,
  jbig2dec,
  lcms2,
  leptonica,
  libjpeg,
  openjpeg,
  tesseract,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-reader";
  version = "0-unstable-2026-05-20";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-reader";
    rev = "c29b3e82c0827133b24dcdb43e1f28a1c7df37a1";
    hash = "sha256-YsRXWSf2l8RfIEXKxvJtYWxhma8N2Y+0/HZwhs7d5k8=";
  };

  cargoHash = "sha256-P9ZC7721MjC/h7sbf7x91WGfMbT4tA46HrYhDgCeiWE=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    fontconfig
    freetype
    gumbo
    harfbuzz
    jbig2dec
    lcms2
    leptonica
    libjpeg
    openjpeg
    tesseract
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

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  meta = {
    description = "PDF reader for the COSMIC Desktop Environment";
    homepage = "https://github.com/pop-os/cosmic-reader";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-reader";
    platforms = lib.platforms.linux;
  };
})
