{
  cosmic-workspaces-epoch,
  fetchFromGitHub,
}:
cosmic-workspaces-epoch.overrideAttrs (finalAttrs: {
  pname = "cosmic-workspaces-epoch";
  version = "epoch-1.2.0-unstable-2026-07-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-workspaces-epoch";
    rev = "3da8907d7a7f97de3de7a90559efa37209b17a74";
    hash = "sha256-C8qQ450jyrdXH6YQDP0xKhV+8GA2f6obMO1/EVn6R+k=";
  };

  cargoHash = "sha256-Z5dC3W8QoDBZWBjHwRj9MC8EScDjQwUiUcOPTRDToDA=";
})
