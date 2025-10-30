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
  version = "epoch-1.0.0-beta.4-unstable-2025-10-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-screenshot";
    rev = "ce9f3e69f76e6e5377517782f80d27800a037c76";
    hash = "sha256-dmp/WfjkiWrmg1NN7f1N+2jl7PkECQSvCbMvjaaZh5w=";
  };

  cargoHash = "sha256-O8fFeg1TkKCg+QbTnNjsH52xln4+ophh/BW/b4zQs9o=";

  nativeBuildInputs = [
    just
    pkg-config
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

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-screenshot";
    description = "Screenshot tool for the COSMIC Desktop Environment";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "cosmic-screenshot";
  };
})
