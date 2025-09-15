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
  version = "0.1.0-unstable-2025-08-05";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-external-monitor-brightness";
    rev = "23104965bd9ab1988b040a60f3f1e5d64038e7ce";
    hash = "sha256-+Hu9bLEbue9bXaGfKa3InhdFI6qsBxccyQY8qzBYFPk=";
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