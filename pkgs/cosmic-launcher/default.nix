{
  cosmic-launcher,
  fetchFromGitHub,
}:
cosmic-launcher.overrideAttrs (finalAttrs: {
  pname = "cosmic-launcher";
  version = "epoch-1.0.15-unstable-2026-06-04";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "6dc22e71f55b4e6dede717f2c27fb60ce33e7e0c";
    hash = "sha256-YTZIQDWPmP7zcoV4/eVROTzCQEjkfqi7ewyzs4cAbj4=";
  };

  cargoHash = "sha256-WnZAPQR8hGGNC5S7hPmcGSMs9HrOw4/wqJR151eIgHY=";
})
