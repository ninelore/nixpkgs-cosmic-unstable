{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-ext-applet-external-monitor-brightness";
  version = "0.0.1-unstable-2025-11-27";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-external-monitor-brightness";
    rev = "3cfba2bbe5e622f887b8236304823fda67c33b46";
    hash = "sha256-UNfIH0Itm1fbRGfh8NdSGeOrm+H8t42yawcZmTjQLQ0=";
  };

  cargoHash = "sha256-ou7iukl1pHMfcJNemwLdZYYxugbJJQ53XpCYowUTj90=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-external-monitor-brightness"
  ];

  meta = {
    homepage = "https://github.com/cosmic-utils/cosmic-ext-applet-external-monitor-brightness";
    description = "Change brightness of external monitors via DDC/CI protocol. You can also quickly toggle system dark mode.";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
