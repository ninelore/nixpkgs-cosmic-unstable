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
  version = "999";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-osd";
    rev = "54c9672fa28c083953b2eae33c38fa4c6ebf3881";
    hash = "sha256-POjuxrNBajp4IOw7YwF2TS4OfoM8Hxo1fO48nkhKj8U=";
  };

  postPatch = ''
    substituteInPlace src/components/app.rs \
      --replace-fail '/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga' '${sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga'
  '';

  cargoHash = "sha256-kfExKggQo3MoTXw1JbKWjLu5kwYF0n7DzSQcG6e1+QQ=";

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
