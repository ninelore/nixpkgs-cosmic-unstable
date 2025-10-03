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
  version = "epoch-1.0.0-beta.1.1-unstable-2025-10-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "15d50421727b65e1bd3e60357dbf116945256b9e";
    hash = "sha256-i+BsLQpcr5qt4FFuVSsdtid9JmQhHrzQrfBu97l139Y=";
  };

  cargoHash = "sha256-v6/lWqGG3uFSFgw77M0kGM+cK9wSiuaGaciPqz/wFIQ=";

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
