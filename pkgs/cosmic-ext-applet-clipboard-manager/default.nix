{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  dbus,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-ext-applet-clipboard-manager";
  version = "0.1.0-unstable-2025-08-05";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "3b4d392f8bae47d5582e308dac0296eeb7365c6a";
    hash = "sha256-NLu4C/UA+4+fCahQx6IcA76ORMkHoUoZZThjWDSS2Hg=";
  };

  cargoHash = "sha256-Ynqb71OnHULvouvulBKQBo41j61aQpLoHnCJwJihTrY=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
    dbus
    udev
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "rootdir"
    (placeholder "out")
    "--set"
    "prefix"
    "\"\""
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-clipboard-manager"
  ];

  meta = {
    homepage = "https://github.com/cosmic-utils/clipboard-manager";
    description = "Clipboard manager applet for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
