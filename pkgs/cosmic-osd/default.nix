{
  lib,
  fetchFromGitHub,
  sound-theme-freedesktop,
  rustPlatform,
  libcosmicAppHook,
  pulseaudio,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-osd";
  version = "epoch-1.0.0-alpha.7-unstable-2025-07-24";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "78e4f7c7b2708b49460342932a22885b8cd7e0cc";
    hash = "sha256-VsZ+FjxClv5oEVmA1Zj28pgNj51vp/RyfylAx3yY01s=";
  };

  postPatch = ''
    substituteInPlace src/components/app.rs \
      --replace-fail '/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga' '${sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga'
  '';

  cargoHash = "sha256-C+R2XgWtErznv6TQZ9eke9/ZNiRUVparP5yHu9442wA=";

  nativeBuildInputs = [ libcosmicAppHook ];

  buildInputs = [
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
