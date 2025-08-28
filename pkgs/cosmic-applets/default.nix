{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch2,
  rustPlatform,
  libcosmicAppHook,
  just,
  pkg-config,
  util-linuxMinimal,
  dbus,
  glib,
  libinput,
  pulseaudio,
  udev,
  xkeyboard_config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-applets";
  version = "999";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applets";
    rev = "f26992e41a7a68aafdd74db4b3c78560282f4e05";
    hash = "sha256-DmU9Dlb8w3a8U+oSGwWARPh1SRbv/8TW7TO9SSvDe1U=";
  };

  cargoHash = "sha256-wWs3B5hh2DP93i+4gGDTi+7NT4bj8ULJ+fT95sXxUdg=";

  nativeBuildInputs = [
    just
    pkg-config
    util-linuxMinimal
    libcosmicAppHook
  ];

  buildInputs = [
    dbus
    glib
    libinput
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
