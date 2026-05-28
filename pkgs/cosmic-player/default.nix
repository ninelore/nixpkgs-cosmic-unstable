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
  version = "epoch-1.0.14-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "31ca4f7af61175ea65b48e4f63447e79f8cdc2a0";
    hash = "sha256-pe6eyy+Yy519DHOTH+MY9ne3S/mwV7FxWhkSgWjBvuE=";
  };

  cargoHash = "sha256-rHw/BAhcnZkC0g/VtkFlXMUL6Et5QKUz0b/uDRXMay4=";

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
