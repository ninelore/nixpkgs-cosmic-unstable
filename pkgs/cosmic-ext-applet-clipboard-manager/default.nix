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
  version = "0.1.0-unstable-2025-09-17";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "500daef29cca7fd4507844041721eed7b92c4dc7";
    hash = "sha256-jb8NsOMIRv9XKAjChhAM9sBk6V2pr8HmCyZXxSV8rnA=";
  };

  cargoHash = "sha256-bOAKicIPeWafF5VEmc4J+mq7sMqvrRNiBNvnobsGqUw=";

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
