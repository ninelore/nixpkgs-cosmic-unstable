{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cosmic-wallpapers";
  version = "epoch-1.0.6-unstable-2026-02-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-wallpapers";
    rev = "3c59953e7ee5792efecdb232cb4c7211e7785f52";
    forceFetchGit = true;
    fetchLFS = true;
    hash = "sha256-m2cYppfitpBDKK8CC9i/lUrC9rfSYTuqUSZSyIKKGyg=";
  };

  makeFlags = [ "prefix=${placeholder "out"}" ];

  meta = {
    description = "Wallpapers for the COSMIC Desktop Environment";
    homepage = "https://system76.com/cosmic";
    license = with lib.licenses; [
      # A_stormy_stellar_nursery_esa_379309.jpg: https://www.esa.int/ESA_Multimedia/Images/2017/06/A_stormy_stellar_nursery
      # webb-inspired-wallpaper-system76.jpg
      cc-by-40

      # otherworldly_earth_nasa_ISS064-E-29444.jpg: https://earthobservatory.nasa.gov/image-use-policy
      # phytoplankton_bloom_nasa_oli2_20240121.jpg: https://earthobservatory.nasa.gov/image-use-policy
      # orion_nebula_nasa_heic0601a.jpg: https://hubblesite.org/copyright
      # tarantula_nebula_nasa_PIA23646.jpg: https://webbtelescope.org/copyright
      # round_moons_nasa.jpg: https://www.planetary.org/space-images/the-solar-systems-round-moons
      publicDomain
    ];
    platforms = lib.platforms.unix;
  };
})
