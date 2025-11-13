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
  version = "epoch-1.0.0-beta.6-unstable-2025-11-12";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "fa1637fe51502f81dc3f2d58d9d14cc6c1ceb1fe";
    hash = "sha256-TiD1gQ44Oqm0qWmZsIcFBG4fjmlr4LWaAMjOx+ulOcE=";
  };

  cargoHash = "sha256-ST/04USAIHvySOoKvh5EPCDlUOjHxbiRFouLunaleKw=";

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
