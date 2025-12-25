{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  pkg-config,
  util-linuxMinimal,
  dbus,
  glib,
  libinput,
  pipewire,
  pulseaudio,
  udev,
  xkeyboard_config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-applets";
  version = "epoch-1.0.0-unstable-2025-12-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applets";
    rev = "2f1b47f2b8f8938d2a5f920186942e945359b873";
    hash = "sha256-geUDsJ7/8DKWjCz6nVIMPx6pKU1KPyLaiKuqIakXx0M=";
  };

  cargoHash = "sha256-RcciTzptZYu6FhJQCPqOxlrW/WNc0qtuTE1P1VQlC+M=";

  nativeBuildInputs = [
    just
    pkg-config
    util-linuxMinimal
    libcosmicAppHook
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    dbus
    glib
    libinput
    pipewire
    pulseaudio
    udev
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "target"
    "${stdenv.hostPlatform.rust.cargoShortTarget}/release"
  ];

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --set-default X11_BASE_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/base.xml
      --set-default X11_EXTRA_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/base.extras.xml
    )
  '';

  meta = {
    homepage = "https://github.com/pop-os/cosmic-applets";
    description = "Applets for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
