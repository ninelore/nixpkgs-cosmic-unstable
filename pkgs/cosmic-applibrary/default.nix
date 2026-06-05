{
  cosmic-applibrary,
  fetchFromGitHub,
}:

cosmic-applibrary.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "ce33b9e1ccbebc2108eddee405a485cb92cb83e3";
    hash = "sha256-ol0WH3L7Vh1ao5rQw0svegWna4Yn8qsq4+uwELLPPN0=";
  };

  cargoHash = "sha256-HvsSK6HO2xQzpdHvUZgkv5cTZsim0ST2lslD+D7qjVs=";
})
