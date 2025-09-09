{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  just,
  pkg-config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-screenshot";
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-screenshot";
    rev = "3ba7f6df76122df296dfab104e1a91207a51f128";
    hash = "sha256-oUsO0DtdrFANhhO3gmGyIBgTFoFAchTZwd5MAverVGU=";
  };

  cargoHash = "sha256-IqduoFFTAwJuUNSJ3t67CnkpGurRLEdZwv0Cc6QoFNk=";

  nativeBuildInputs = [
    just
    pkg-config
  ];

  dontUseJustBuild = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-screenshot"
  ];

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-screenshot";
    description = "Screenshot tool for the COSMIC Desktop Environment";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "cosmic-screenshot";
  };
})
