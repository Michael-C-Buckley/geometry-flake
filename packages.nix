{ nixpkgs }:

let
  architectures = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  makePackage =
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    pkgs.stdenv.mkDerivation {
      pname = "geometry";
      version = "stable";

      src = pkgs.fetchFromGitHub {
        owner = "geometry-zsh";
        repo = "geometry";
        rev = "7e245c627d0b4c58dffc59899c9ef9f5027adba0";
        sha256 = "sha256-kUxtqKQb0OugDkflPQ49OoH51kwgjBHBeNrS1fE8inE=";
      };

      installPhase = ''
        mkdir -p $out/share/zsh/site-functions
        cp geometry.zsh $out/share/zsh/site-functions/geometry.zsh
      '';

      meta = {
        description = "A minimal, fully customizable and composable zsh prompt theme ";
        homepage = "https://github.com/geometry-zsh/geometry";
        license = pkgs.lib.licenses.isc;
      };
    };
in
builtins.listToAttrs (
  map (system: {
    name = system;
    value = makePackage system;
  }) architectures
)
