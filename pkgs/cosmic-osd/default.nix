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
  version = "epoch-1.0.16-unstable-2026-05-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "28af81d1a7479b4e9edddb2fcf8c93f2074bad6b";
    hash = "sha256-jv28hxhQUcUDLnOwU3xQJwCU+s52pwDNs8Gf4I5Hp9k=";
  };

  cargoHash = "sha256-BngWy8fSfmQYSLV+/3jBvDdI0lpTwqGUiwwHvDlqySw=";

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
