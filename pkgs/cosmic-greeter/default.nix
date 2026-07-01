{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  cmake,
  just,
  libinput,
  linux-pam,
  udev,
  coreutils,
  xkeyboard_config,
  orca,
  cosmic-randr,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-greeter";
  version = "epoch-1.2.0-unstable-2026-06-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "953478f801eb0c67062b6e1d540c6d6bf5edc992";
    hash = "sha256-JaPF2kFXQLumPBn8JFBiaSJ/tP3QqK/hwhy5rZrLuY4=";
  };

  cargoHash = "sha256-mfY2hsMxBooRjmTB2jgUIKyKHBpGfZ9Qslwv+2aEQyg=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  cargoBuildFlags = [ "--all" ];

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    cmake
    just
    libcosmicAppHook
  ];

  buildInputs = [
    cosmic-randr
    libinput
    linux-pam
    udev
    orca
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

  postPatch = ''
    substituteInPlace src/greeter.rs --replace-fail '/usr/bin/env' '${lib.getExe' coreutils "env"}'
    substituteInPlace src/greeter.rs --replace-fail '/usr/bin/orca' '${lib.getExe orca}'
  '';

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --prefix PATH : ${lib.makeBinPath [ cosmic-randr ]}
      --set-default X11_BASE_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/base.xml
      --set-default X11_BASE_EXTRA_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/extra.xml
    )
  '';

  meta = {
    homepage = "https://github.com/pop-os/cosmic-greeter";
    description = "Greeter for the COSMIC Desktop Environment";
    mainProgram = "cosmic-greeter";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
