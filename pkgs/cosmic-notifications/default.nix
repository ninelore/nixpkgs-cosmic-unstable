{
  cosmic-notifications,
  fetchFromGitHub,
}:

cosmic-notifications.overrideAttrs (finalAttrs: {
  pname = "cosmic-notifications";
  version = "epoch-1.2.0-unstable-2026-07-10";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-notifications";
    rev = "7c723b7705ec77b1ad5396a1baa9ae1c0cb5a0da";
    hash = "sha256-6Po/6VK1n8inpiMEESKwBHE0XL692XZj3w/R8evvh4I=";
  };

  cargoHash = "sha256-EIwYabYWSHTMnNFcammidn3bI4fc6JFdcVkGj7RmWqA=";
})
