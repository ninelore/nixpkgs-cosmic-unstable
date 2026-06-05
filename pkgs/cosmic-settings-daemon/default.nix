{
  cosmic-settings-daemon,
  fetchFromGitHub,
}:
cosmic-settings-daemon.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "8c54bbbc10485c31e8717c21e119e19b87eeb3ea";
    hash = "sha256-hgvw7+/3olCitNgHVEJfB8q274Ya+FegUhTHJ74U2EY=";
  };

  cargoHash = "sha256-bz+JasI3WE30sKKgjofVO/42Ml4YY9Dw3JxnZmZVQk4=";
})
