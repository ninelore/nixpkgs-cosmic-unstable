{
  lib,
  fetchFromGitHub,
  sound-theme-freedesktop,
  rustPlatform,
  libcosmicAppHook,
  pipewire,
  pulseaudio,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-osd";
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "aa8a7d5a01489bbf56e33f45abcadf1e497d7757";
    hash = "sha256-UYJck+j8q+cN1aFkETNg/BE+BfJj2bV72Dw2UrCYl5Y=";
  };

  postPatch = ''
    substituteInPlace src/components/app.rs \
      --replace-fail '/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga' '${sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga'
  '';

  cargoHash = "sha256-090ifWvXb2Idd/LBybDTbmKx4QGYa4I0EDRs4yKbI4A=";

  nativeBuildInputs = [
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  buildInputs = [
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
