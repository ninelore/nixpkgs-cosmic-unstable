{
  cosmic-applibrary,
  fetchFromGitHub,
  rustPlatform,
}:

cosmic-applibrary.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-26";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-applibrary";
      rev = "1eb859fdd7617420ea526f81af168842d0ef428b";
      hash = "sha256-mzHSLZK6HienbPRPetSj+XbPWCnpihEvMx9W9lJWpbA=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
