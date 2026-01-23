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
  version = "epoch-1.0.3-unstable-2026-01-23";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "f3e9de242547f6e099fb6e48cf884c53b5ebc90d";
    hash = "sha256-iZLbNESx041/m8zNO9ZGciEpKqz7TTiIwHdAJvjiNUo=";
  };

  cargoHash = "sha256-sNJTXBInr/h8w5dhOOP9ceBYWBcJW3qGjDuaG6UTV90=";

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
