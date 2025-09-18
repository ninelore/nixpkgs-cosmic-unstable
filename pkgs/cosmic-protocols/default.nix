{
  lib,
  stdenv,
  fetchFromGitHub,
  wayland-scanner,
}:

stdenv.mkDerivation {
  pname = "cosmic-protocols";
  version = "0-unstable-2025-09-17";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-protocols";
    rev = "af1997b1827ad64aab46fa31c0b77fb20d7a537a";
    hash = "sha256-gIfCk8FqZo1iFwTTtcLqnX14Jg3k6UXIBkpKsom43EU=";
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
