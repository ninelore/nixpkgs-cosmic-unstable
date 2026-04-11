{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  just,
  pop-icon-theme,
  hicolor-icon-theme,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cosmic-icons";
  version = "epoch-1.0.9-unstable-2026-04-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-icons";
    rev = "eb1c1da0f5889277eb93d941689cb2c1c0c3fe98";
    hash = "sha256-h6vnOL3T4o2VDoQ5vLGg3s6nMYcPKysI5RxbjnbnCFI=";
  };

  nativeBuildInputs = [ just ];

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
  ];

  propagatedBuildInputs = [
    pop-icon-theme
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  meta = {
    description = "System76 Cosmic icon theme for Linux";
    homepage = "https://github.com/pop-os/cosmic-icons";
    license = with lib.licenses; [
      cc-by-sa-40
    ];
  };
})
