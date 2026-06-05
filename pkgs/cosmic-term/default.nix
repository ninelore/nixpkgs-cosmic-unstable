{
  cosmic-term,
  fetchFromGitHub,
}:
cosmic-term.overrideAttrs (finalAttrs: {
  pname = "cosmic-term";
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "3832971d04076c873370cc9a993b7b3178e3d2e3";
    hash = "sha256-d4hX78WQNdzIsapQaWlD3p0IDQWgJ9cqGzhUQBMaNUQ=";
  };

  cargoHash = "sha256-uXtAuIyzjx6t11ozZ28WHqfqQfJY4VchHC9POXul8Hk=";
})
