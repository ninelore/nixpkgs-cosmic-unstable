{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  cmake,
  just,
  libcosmicAppHook,
  pkg-config,
  expat,
  libinput,
  fontconfig,
  freetype,
  pipewire,
  pulseaudio,
  udev,
  util-linux,
  cosmic-randr,
  xkeyboard_config,
}:
let
  libcosmicAppHook' = (libcosmicAppHook.__spliced.buildHost or libcosmicAppHook).override {
    includeSettings = false;
  };
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-settings";
  version = "epoch-1.0.0-beta.1.1-unstable-2025-10-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings";
    rev = "7ce9b00605fc624531d81d7d4e6f08a315c0c512";
    hash = "sha256-ru4ePq8H69DNMQgsBbwEyTFf0w/jSOl7WyMTnvNq3T0=";
  };

  cargoHash = "sha256-mMfKY+ouszbN2rEf6zvv1Sc1FEZ/ZVuQ6RXGMBFDwIE=";

  nativeBuildInputs = [
    cmake
    just
    libcosmicAppHook'
    pkg-config
    rustPlatform.bindgenHook
    util-linux
  ];

  buildInputs = [
    expat
    fontconfig
    freetype
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
    "cargo-target-dir"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --prefix PATH : ${lib.makeBinPath [ cosmic-randr ]}
      --set-default X11_BASE_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/base.xml
      --set-default X11_BASE_EXTRA_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/extra.xml
    )
  '';

  meta = {
    description = "Settings for the COSMIC Desktop Environment";
    homepage = "https://github.com/pop-os/cosmic-settings";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-settings";
    platforms = lib.platforms.linux;
  };
})
