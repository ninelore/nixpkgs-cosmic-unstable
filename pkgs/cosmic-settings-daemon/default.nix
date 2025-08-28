{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  pop-gtk-theme,
  adw-gtk3,
  pkg-config,
  libpulseaudio,
  geoclue2-with-demo-agent,
  libinput,
  openssl,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-settings-daemon";
  version = "epoch-1.0.0-alpha.7-unstable-2025-08-22";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "3f72461e99ed9acaccd3199d8888cf619dc5f511";
    hash = "sha256-Y9JtCXTjtIbUJs4UEedeyH7uWOcbHpWJqubkMND1RiU=";
  };

  postPatch = ''
    substituteInPlace src/battery.rs \
      --replace-fail '/usr/share/sounds/Pop/' '${pop-gtk-theme}/share/sounds/Pop/'
    substituteInPlace src/theme.rs \
      --replace-fail '/usr/share/themes/adw-gtk3' '${adw-gtk3}/share/themes/adw-gtk3'
  '';

  cargoHash = "sha256-9BeC0Y29NOMoEJHKLV3aRHZQbglbLnnTH4uS3h129iw=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libinput
    libpulseaudio
    openssl
    udev
  ];

  env.GEOCLUE_AGENT = "${lib.getLib geoclue2-with-demo-agent}/libexec/geoclue-2.0/demos/agent";

  makeFlags = [
    "prefix=$(out)"
    "CARGO_TARGET_DIR=target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  dontCargoInstall = true;

  meta = with lib; {
    homepage = "https://github.com/pop-os/cosmic-settings-daemon";
    description = "Settings Daemon for the COSMIC Desktop Environment";
    mainProgram = "cosmic-settings-daemon";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
})
