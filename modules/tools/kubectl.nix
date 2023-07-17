{ pkgs, lib, ... }:

let
  cfg = config.tools.kubectl;
in
{
  options.tools.kubectl = {
    enable = lib.mkEnableOption "Kubernetes CLI";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kubectl;
      defaultText = lib.literalExpression "pkgs.kubectl";
      description = "The kubectl package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    env.KUBECONFIG = config.env.DEVENV_STATE + "/kube/config";

    versions.exec = "${cfg.package}/bin/kubectl version --client";
  };
}
