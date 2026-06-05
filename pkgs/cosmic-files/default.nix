{
  cosmic-files,
  fetchFromGitHub,
}:
cosmic-files.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-files";
    rev = "c605dbecaf70e193a98fec775f7381a943d264a2";
    hash = "sha256-o9f5/MR0sQ325tilTK0arzSAp3OUuAHCBDS8iMidUqU=";
  };

  cargoHash = "sha256-WOhWgd1fFdlc7o1YtJJnpsHXxwtCQWV1MWmbDsAqxNg=";
})
