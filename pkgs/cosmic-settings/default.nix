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
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-07";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings";
    rev = "f3456ffc18d7f089a441f4b5fd77fe94943c665e";
    hash = "sha256-B39/WBoev3i/bTWq+VkStuJwUp8hZCnPzsrUyQCsDzA=";
  };

  cargoHash = "sha256-+d9c2VdJ+DT2H4zfV9znPlb1ZQZmh382Q/VTpjaT9ys=";

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
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-settings"
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
