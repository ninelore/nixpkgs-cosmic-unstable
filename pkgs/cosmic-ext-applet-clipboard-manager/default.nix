{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  dbus,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-ext-applet-clipboard-manager";
  version = "0.1.0-unstable-2025-12-26";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "b4d8e869cf87815758e8956fe6d0e70e82dc81c9";
    hash = "sha256-zz2ktNHZnyhvAtzasXfsmb3kpi+RxyjCcnQSUprLshM=";
  };

  cargoHash = "sha256-DmxrlYhxC1gh5ZoPwYqJcAPu70gzivFaZQ7hVMwz3aY=";

  patches = [ ./0001-justfile-drop-export.patch ];

  env.CLIPBOARD_MANAGER_COMMIT = finalAttrs.src.rev;

  nativeBuildInputs = [
    just
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
    dbus
    udev
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "rootdir"
    (placeholder "out")
    "--set"
    "prefix"
    "\"\""
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-clipboard-manager"
  ];

  meta = {
    homepage = "https://github.com/cosmic-utils/clipboard-manager";
    description = "Clipboard manager applet for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
