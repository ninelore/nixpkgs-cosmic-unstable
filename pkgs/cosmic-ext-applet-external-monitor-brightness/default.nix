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
  version = "0.0.1-unstable-2025-09-17";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-external-monitor-brightness";
    rev = "1f648171fcc1b187ca6603b78c650ea0f33daa79";
    hash = "sha256-QXQqHtXYoq2cg2DKL8DHZz2T+MsnCtI5mRJP036UC2U=";
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