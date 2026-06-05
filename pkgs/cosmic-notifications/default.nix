{
  cosmic-notifications,
  fetchFromGitHub,
}:

cosmic-notifications.overrideAttrs (finalAttrs: {
  pname = "cosmic-notifications";
  version = "epoch-1.0.15-unstable-2026-04-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "a899bfbc6715c36b1f02d7a0f4d3601a3ea0295f";
    hash = "sha256-84e+idGKYDBerS84Cl9jPc/Z9RzuVvND7nHzmApsrgA=";
  };

  cargoHash = "sha256-EIwYabYWSHTMnNFcammidn3bI4fc6JFdcVkGj7RmWqA=";
})
