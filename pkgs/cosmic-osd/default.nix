{
  lib,
  fetchFromGitHub,
  # sound-theme-freedesktop,
  rustPlatform,
  libcosmicAppHook,
  libinput,
  pipewire,
  pulseaudio,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-osd";
  version = "0-unstable-2026-05-11";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "cb9698c8536df05b7086115a071a3d3838b245f2";
    hash = "sha256-KWzNW40KNljoo1X97dumVbaDLQM7m8LZkbM/4DjLg2s=";
  };

  cargoHash = "sha256-1YRWWI2qhCI0GrxBAAkGT/AbtkTHgdbYsG8obriZ+zg=";

  nativeBuildInputs = [
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    libinput
    pipewire
    pulseaudio
    udev
  ];

  env.POLKIT_AGENT_HELPER_1 = "/run/wrappers/bin/polkit-agent-helper-1";

  meta = {
    homepage = "https://github.com/pop-os/cosmic-osd";
    description = "OSD for the COSMIC Desktop Environment";
    mainProgram = "cosmic-osd";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
