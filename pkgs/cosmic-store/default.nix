{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  pkg-config,
  just,
  glib,
  flatpak,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-store";
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-14";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-store";
    rev = "f39eef77621c0c3aff33723ef1d1c7affccc80f4";
    hash = "sha256-GpeCnvIt9IYaXkkeOsx0joCgck61p74xg8qywFnzAYg=";
  };

  cargoHash = "sha256-X6XTanAFQFTxs1w7As3QpRcSRCbSTEJmo7HTG6bk4v4=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
  ];

  buildInputs = [
    glib
    flatpak
    openssl
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-store"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-store";
    description = "App Store for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
