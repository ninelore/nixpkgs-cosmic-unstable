{
  lib,
  stdenv,
  fetchFromGitHub,
  wayland-scanner,
}:

stdenv.mkDerivation {
  pname = "cosmic-protocols";
  version = "0-unstable-2025-09-01";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-protocols";
    rev = "6254f50abc6dbfccadc6939f80e20081ab5f9d51";
    hash = "sha256-gOYgz07RGZoBp2RbHn0jUGLGXH/geoch/Y27Qh+jBao=";
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
