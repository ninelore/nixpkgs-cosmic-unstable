{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  pop-gtk-theme,
  adw-gtk3,
  pkg-config,
  libpulseaudio,
  libinput,
  openssl,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-settings-daemon";
  version = "epoch-1.0.8-unstable-2026-03-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "e37160f14d1e7ee428f973cd2848b4e95f83dfe1";
    hash = "sha256-rI9HFfIDb/FiW6JjNQdnkOS4jF4H1R51SIl56UZKvP8=";
  };

  postPatch = ''
    substituteInPlace src/battery.rs \
      --replace-fail '/usr/share/sounds/Pop/' '${pop-gtk-theme}/share/sounds/Pop/'
    substituteInPlace src/theme.rs \
      --replace-fail '/usr/share/themes/adw-gtk3' '${adw-gtk3}/share/themes/adw-gtk3'
  '';

  cargoHash = "sha256-srGV9ddIuxGYvNWmTPcXUDCYmDNOfYG31UwtdVPGsyE=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libinput
    libpulseaudio
    openssl
    udev
  ];

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
