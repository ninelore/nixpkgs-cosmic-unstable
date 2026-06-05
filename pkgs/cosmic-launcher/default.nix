{
  cosmic-launcher,
  fetchFromGitHub,
}:
cosmic-launcher.overrideAttrs (finalAttrs: {
  pname = "cosmic-launcher";
  version = "epoch-1.2.0-unstable-2026-07-09";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-launcher";
    rev = "61ab43a71a0e684a76b0f7a40199c585862148a8";
    hash = "sha256-7UqBeyXyttJh620366/kd7RnV0VmP4WCKIKayOT8yEk=";
  };

  cargoHash = "sha256-WnZAPQR8hGGNC5S7hPmcGSMs9HrOw4/wqJR151eIgHY=";
})
