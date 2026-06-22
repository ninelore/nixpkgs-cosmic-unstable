{
  cosmic-applibrary,
  fetchFromGitHub,
}:

cosmic-applibrary.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "1eb859fdd7617420ea526f81af168842d0ef428b";
    hash = "sha256-mzHSLZK6HienbPRPetSj+XbPWCnpihEvMx9W9lJWpbA=";
  };

  cargoHash = "sha256-HvsSK6HO2xQzpdHvUZgkv5cTZsim0ST2lslD+D7qjVs=";
})
