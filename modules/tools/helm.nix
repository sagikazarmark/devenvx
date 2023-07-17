{ config, pkgs, lib, ... }:

let
  cfg = config.tools.helm;
in
{
  options.tools.helm = {
    enable = lib.mkEnableOption "A package manager for Kubernetes";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kubernetes-helm;
      defaultText = lib.literalExpression "pkgs.kubernetes-helm";
      description = "The Helm package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    env.HELM_CACHE_HOME = config.env.DEVENV_STATE + "/helm/cache";
    env.HELM_CONFIG_HOME = config.env.DEVENV_STATE + "/helm/config";
    env.HELM_DATA_HOME = config.env.DEVENV_STATE + "/helm/data";

    versions.exec = "echo helm $(${cfg.package}/bin/helm version --short)";
  };
}
