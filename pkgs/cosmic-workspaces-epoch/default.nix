{
  cosmic-workspaces-epoch,
  fetchFromGitHub,
}:
cosmic-workspaces-epoch.overrideAttrs (finalAttrs: {
  pname = "cosmic-workspaces-epoch";
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-workspaces-epoch";
    rev = "5e62de143a02073200b075036626f56ad4140589";
    hash = "sha256-u4p22qpxZPdBogzrJXGomqGGxgkpD0hdXf+3YNg2VIo=";
  };

  cargoHash = "sha256-Z5dC3W8QoDBZWBjHwRj9MC8EScDjQwUiUcOPTRDToDA=";
})
