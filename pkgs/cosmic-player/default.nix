{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  pkg-config,
  alsa-lib,
  ffmpeg,
  glib,
  gst_all_1,
  libglvnd,
  libgbm,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-player";
  version = "epoch-1.0.0-unstable-2025-12-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "29c8fb3675d91c3446c345e9bc88856aa4ed7325";
    hash = "sha256-+DFMBMJuKPZ8T9PdR3/Qt9lF688TYS1AhbkVK2yudU4=";
  };

  cargoHash = "sha256-Z0+6jtvJ3z/ptcqrbvSuXgjH2liASNJwBIKiHbrVBT8=";

  nativeBuildInputs = [
    just
    pkg-config
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  # Largely based on lilyinstarlight's work linked below
  # https://github.com/lilyinstarlight/nixos-cosmic/blob/main/pkgs/cosmic-player/package.nix

  buildInputs = [
    alsa-lib
    ffmpeg
    glib
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    libgbm
    libglvnd
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

  postInstall = ''
    libcosmicAppWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  meta = {
    homepage = "https://github.com/pop-os/cosmic-player";
    description = "Media player for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-player";
  };
})
