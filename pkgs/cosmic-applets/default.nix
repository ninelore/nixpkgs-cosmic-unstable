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
  version = "epoch-1.0.8-unstable-2026-03-23";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applets";
    rev = "03ce06500637eda87953e4572fb76bf52cb3b2bc";
    hash = "sha256-3XwwD3UeEig1VRpHm6Ca5/oDy2knvh3hiaNO/H6Ixt8=";
  };

  cargoHash = "sha256-Ex9VbbX0aTwnWxctJulIUeDwQT4ylEy7q8VvuLd176M=";

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
