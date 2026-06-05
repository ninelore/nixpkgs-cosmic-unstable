{
  cosmic-term,
  fetchFromGitHub,
}:
cosmic-term.overrideAttrs (finalAttrs: {
  pname = "cosmic-term";
  version = "epoch-1.2.0-unstable-2026-07-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-term";
    rev = "46f8b1a9cf6f8269feb8f1cded0ee3291f029f08";
    hash = "sha256-kWZEDXjN0C8bz8a2dRxvERwYnsn6epIHC4tY8eRgFSY=";
  };

  cargoHash = "sha256-uXtAuIyzjx6t11ozZ28WHqfqQfJY4VchHC9POXul8Hk=";
})
