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
  version = "epoch-1.0.16-unstable-2026-06-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "1eb859fdd7617420ea526f81af168842d0ef428b";
    hash = "sha256-mzHSLZK6HienbPRPetSj+XbPWCnpihEvMx9W9lJWpbA=";
  };

  cargoHash = "sha256-qGx/3w78mgIMqRo1wJA+ULFHWdNW2LKe2Sej4f9KbVs=";

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
