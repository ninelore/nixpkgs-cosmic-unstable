{
  cosmic-protocols,
  fetchFromGitHub,
}:
cosmic-protocols.overrideAttrs {
  version = "0-unstable-2026-05-08";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-protocols";
    rev = "e95d89504513e1407f89a189aca328fbecc9eeef";
    hash = "sha256-u1Ur9lPm2HE60jCEJVhKtbGYfzV8pdiDjrsGwgKf3nA=";
  };
}
