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
  version = "epoch-1.0.0-beta.1-unstable-2025-09-22";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "fc095b351ba03011c384b89170d9557a6052f390";
    hash = "sha256-tsP4dlHmzuf5QgByDWbuigMrpgnJAjuNsYwWDSutCoI=";
  };

  cargoHash = "sha256-YcNvvK+Zf8nSS5YjS5iaoipogstiyBdNY7LhWPsz9xQ=";

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
