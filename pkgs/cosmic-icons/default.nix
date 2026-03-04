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
  version = "epoch-1.0.8-unstable-2026-03-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-icons";
    rev = "5252095787cc96e2aed64604158f94e450703455";
    hash = "sha256-3VlI3nd5ICPJASCNQjmojbaxn5Y5+bHvQEHIY5A6Ow0=";
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
