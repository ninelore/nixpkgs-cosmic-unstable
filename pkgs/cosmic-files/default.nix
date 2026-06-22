{
  cosmic-files,
  fetchFromGitHub,
}:
cosmic-files.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-files";
    rev = "53a33dbe7403907a626815d9c120716dc22407a5";
    hash = "sha256-Gxx1gTTS/2tuPOFJOwmGlWK9DWNLig8obDNp6ZUvkVc=";
  };

  cargoHash = "sha256-WOhWgd1fFdlc7o1YtJJnpsHXxwtCQWV1MWmbDsAqxNg=";
})
