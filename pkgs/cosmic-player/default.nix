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
  version = "epoch-1.0.0-beta.4-unstable-2025-10-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-player";
    rev = "f80353c571ba4b672614b3bafaeae49b1a8e1ac1";
    hash = "sha256-2a5Ncq9cSGs/u+Cow4Ia8ilTkj+7pG3tjEzD5edI4/M=";
  };

  cargoHash = "sha256-fnX5BkzRAetKxHZ9XyWdmG6TSxFqGJsmg16zlpYG9Ag=";

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
