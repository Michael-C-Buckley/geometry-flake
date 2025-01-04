# Home-Manager options

{ config, lib, pkgs, ... }:

with lib;

let
  defaultPath = "${pkgs.geometry}/share/zsh/site-functions/geometry.zsh";
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

  config = mkIf config.programs.zsh.geometry.enable {
    programs.zsh.shellInit = ''
      if [ -f ${config.programs.zsh.geometry.path} ]; then
        source ${config.programs.zsh.geometry.path}
      fi
    '';
  };
}
