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
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-settings-daemon";
  version = "999";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "bb9eb904e800d09965e33883e4e15dfd011b1d19";
    hash = "sha256-vdhkE5CmgiGYg5TXxN7lLqxjv7apKEKvIscXFIzZfRc=";
  };

  postPatch = ''
    substituteInPlace src/battery.rs \
      --replace-fail '/usr/share/sounds/Pop/' '${pop-gtk-theme}/share/sounds/Pop/'
    substituteInPlace src/theme.rs \
      --replace-fail '/usr/share/themes/adw-gtk3' '${adw-gtk3}/share/themes/adw-gtk3'
  '';

  cargoHash = "sha256-Dzv1SDeZFIa+LFQQ91lO7RBHldsjDnGf+R12Ln2WZwU=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libinput
    libpulseaudio
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
