{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  cosmic-wallpapers,
  libcosmicAppHook,
  just,
  nasm,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-bg";
  version = "epoch-1.0.0-alpha.7-unstable-2025-08-18";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-bg";
    rev = "d46d05e159a22a30713f5f49f1a79ec9a2630d96";
    hash = "sha256-z7PtP5sDj4Vb74eNeEDcXgoRRKcVT17Dlvx9XHX/9+4=";
  };

  postPatch = ''
    substituteInPlace config/src/lib.rs data/v1/all \
      --replace-fail '/usr/share/backgrounds/cosmic/orion_nebula_nasa_heic0601a.jpg' \
      "${cosmic-wallpapers}/share/backgrounds/cosmic/orion_nebula_nasa_heic0601a.jpg"
  '';

  cargoHash = "sha256-iCQjPZH3CN73R6PmFRndLcPZGQfxeaPSYPZgbGofKkM=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
    nasm
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-bg"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-bg";
    description = "Applies Background for the COSMIC Desktop Environment";
    license = lib.licenses.mpl20;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-bg";
  };
})
