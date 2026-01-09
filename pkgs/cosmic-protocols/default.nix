{
  lib,
  stdenv,
  fetchFromGitHub,
  wayland-scanner,
}:

stdenv.mkDerivation {
  pname = "cosmic-protocols";
  version = "0-unstable-2026-01-08";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-protocols";
    rev = "160b086abe03cd34a8a375d7fbe47b24308d1f38";
    hash = "sha256-ymn+BUTTzyHquPn4hvuoA3y1owFj8LVrmsPu2cdkFQ8=";
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
