{
  lib,
  stdenv,
  fetchFromGitHub,
  wayland-scanner,
}:

stdenv.mkDerivation {
  pname = "cosmic-protocols";
  version = "999";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-protocols";
    rev = "8e84152fedf350d2756a2c1c90e07313acb9cdf6";
    hash = "sha256-rFoSSc2wBNiW8wK3AIKxyv28FNTEiGk6UWjp5dQVxe8=";
  };

  makeFlags = [ "PREFIX=${placeholder "out"}" ];
  nativeBuildInputs = [ wayland-scanner ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-protocols";
    description = "Additional wayland-protocols used by the COSMIC desktop environment";
    license = with lib.licenses; [
      mit
      gpl3Only
    ];
    platforms = lib.platforms.linux;
  };
}
