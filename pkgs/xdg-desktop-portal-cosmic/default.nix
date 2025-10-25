{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  pkg-config,
  util-linux,
  libgbm,
  pipewire,
  gst_all_1,
  cosmic-wallpapers,
  coreutils,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "xdg-desktop-portal-cosmic";
  version = "epoch-1.0.0-beta.3-unstable-2025-10-24";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "xdg-desktop-portal-cosmic";
    rev = "100ed29395c78a3d3181d94bd74c5d2425c8a537";
    hash = "sha256-szH9z9SvTIdi+Nq7oQGVzOWjRT5GMrQ00/uIpQm8TLA=";
    deepClone = true;
  };

  cargoHash = "sha256-48gK3rRmtvXmmY6Ut5qd94/aGq7UyYZvtCipWgiSGLg=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  nativeBuildInputs = [
    libcosmicAppHook
    rustPlatform.bindgenHook
    pkg-config
    util-linux
  ];

  buildInputs = [
    libgbm
    pipewire
  ];

  checkInputs = [ gst_all_1.gstreamer ];

  postPatch = ''
    # While the `kate-hazen-COSMIC-desktop-wallpaper.png` image is present
    # in the `pop-wallpapers` package, we're using the Orion Nebula image
    # from NASA available in the `cosmic-wallpapers` package. Mainly because
    # the previous image was used in the GNOME shell extension and the
    # Orion Nebula image is widely used in the Rust-based COSMIC DE's
    # marketing materials. Another reason to use the Orion Nebula image
    # is that it's actually the default wallpaper as configured by the
    # `cosmic-bg` package's configuration in upstream [1] [2].
    #
    # [1]: https://github.com/pop-os/cosmic-bg/blob/epoch-1.0.0-alpha.6/config/src/lib.rs#L142
    # [2]: https://github.com/pop-os/cosmic-bg/blob/epoch-1.0.0-alpha.6/data/v1/all#L3
    substituteInPlace src/screenshot.rs src/widget/screenshot.rs \
      --replace-fail '/usr/share/backgrounds/pop/kate-hazen-COSMIC-desktop-wallpaper.png' '${cosmic-wallpapers}/share/backgrounds/cosmic/orion_nebula_nasa_heic0601a.jpg'
  '';

  dontCargoInstall = true;

  makeFlags = [
    "prefix=${placeholder "out"}"
    "CARGO_TARGET_DIR=target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  meta = {
    homepage = "https://github.com/pop-os/xdg-desktop-portal-cosmic";
    description = "XDG Desktop Portal for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    mainProgram = "xdg-desktop-portal-cosmic";
    platforms = lib.platforms.linux;
  };
})
