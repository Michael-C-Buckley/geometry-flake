{stdenv, pkgs, lib}:
stdenv.mkDerivation rec {
  src = pkgs.fetchFromGitHub {
    owner = "geometry-zsh";
    repo = "geometry";
    rev = "7e245c627d0b4c58dffc59899c9ef9f5027adba0";
    sha256 = "sha256-kUxtqKQb0OugDkflPQ49OoH51kwgjBHBeNrS1fE8inE=";
  };
  pname = "geometry-zsh";
  version = "dba0"; # From the last 4 of the latest source repository revision since no actual version exists
  meta = with lib; {
    maintainers = [ maintainers.michaelbuckley ];
    platform = platforms.all;
    license = licenses.isc;
  };

  installPhase = ''
    mkdir -p $out/share/zsh
    cp -r * $out/share/zsh/
  '';
}
