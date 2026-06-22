{
  cosmic-osd,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-osd.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-29";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-osd";
      rev = "4e60034f0574e079c5577097a8a1ebeb3e7acf96";
      hash = "sha256-ZW4o4NmgDnJdx1zHRH0mTQP+/zpi31oCjiRKVYXMyOs=";
    };

    patches = [ ];

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
