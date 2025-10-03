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
  version = "epoch-1.0.0-beta.1.1-unstable-2025-10-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-bg";
    rev = "d9819430ace9923c1a5a88be875036084d101829";
    hash = "sha256-Z3nqiMWIWvX/Jdf/DnJU95YOEGRJSFQ3+eSHFuY9QhE=";
  };

  postPatch = ''
    substituteInPlace config/src/lib.rs data/v1/all \
      --replace-fail '/usr/share/backgrounds/cosmic/orion_nebula_nasa_heic0601a.jpg' \
      "${cosmic-wallpapers}/share/backgrounds/cosmic/orion_nebula_nasa_heic0601a.jpg"
  '';

  cargoHash = "sha256-+NkraWjWHIMIyktAUlp3q2Ot1ib1QRsBBvfdbr5BXto=";

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
