{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  just,
  killall,
  libcosmicAppHook,
  libinput,
  openssl,
  udev,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-initial-setup";
  version = "epoch-1.0.5-unstable-2026-01-31";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-initial-setup";
    rev = "467be1a39dcc6f5f4763dbe453e48e4eee972c32";
    hash = "sha256-y2wRVAnCh1B45MZLj0e1waAJlsp/cUUcshuHItyCQgs=";
  };

  cargoHash = "sha256-Kj+eaTMHMQQHN0X3prIuZm1wvfnaV7BUlUKem6JLtc8=";

  buildFeatures = [ "nixos" ];

  # cargo-auditable fails during the build when compiling the `crabtime::function`
  # procedural macro. It panics because the `--out-dir` flag is not passed to
  # the rustc wrapper.
  auditable = false;

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  buildInputs = [
    killall
    libinput
    openssl
    udev
  ];

  postPatch = ''
    # Installs in $out/etc/xdg/autostart instead of /etc/xdg/autostart
    substituteInPlace justfile \
      --replace-fail \
      "autostart-dst := rootdir / 'etc' / 'xdg' / 'autostart' / desktop-entry" \
      "autostart-dst := prefix / 'etc' / 'xdg' / 'autostart' / desktop-entry"
  '';

  preFixup = ''
    libcosmicAppWrapperArgs+=(--prefix PATH : ${lib.makeBinPath [ killall ]})
  '';

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

  env.DISABLE_IF_EXISTS = "/iso/nix-store.squashfs";

  meta = {
    description = "COSMIC Initial Setup";
    homepage = "https://github.com/pop-os/cosmic-initial-setup";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-initial-setup";
    platforms = lib.platforms.linux;
  };
})
