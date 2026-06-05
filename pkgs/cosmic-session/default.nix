{
  cosmic-session,
  fetchFromGitHub,
}:

cosmic-session.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-07";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-session";
    rev = "495e591dc65987a0327b9dea646126ebdfe8a1db";
    hash = "sha256-FphY53MaOUUR2oQfZak3HbT+kvysUnw2AIc4L9O+TcU=";
  };

  cargoHash = "sha256-5dLG40X+yxJo566guyHqOCLNp+uNSE+HONS8GIDm58A=";
})
