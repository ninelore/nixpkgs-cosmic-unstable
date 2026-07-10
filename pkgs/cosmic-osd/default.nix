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
  version = "epoch-1.2.0-unstable-2026-07-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "ce431b4d710a198b13298c96d22fe5ccaadb1943";
    hash = "sha256-18QURT3L1RloFqsr9PR5Ts7YtbhmkCJU4w7E5d/OJIA=";
  };

  cargoHash = "sha256-5hput7WMstON8YG9GNNU61T+bQevGV72mAHYMtJJXng=";

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
