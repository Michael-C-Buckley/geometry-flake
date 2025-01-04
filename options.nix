# Home-Manager options

{ self, config, lib, pkgs, ... }:

with lib;

let
  defaultPath = "${pkgs.geometry}/share/zsh/site-functions/geometry.zsh";
  geometryConfig = config.programs.zsh.geometry;
  geometryPackage = self.packages.${pkgs.system};
in {
  options.programs.zsh.geometry = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Geometry Zsh prompt.";
    };

    path = mkOption {
      type = types.str;
      default = defaultPath;
      description = "Path to the Geometry Zsh script.";
    };
  };

  config = mkIf geometryConfig.enable {
    home.packages = [ geometryPackage ];
    programs.zsh.shellInit = ''
      if [ -f ${geometryConfig.path} ]; then
        source ${geometryConfig.path}
      fi
    '';
  };
}
