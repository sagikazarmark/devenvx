{ config, pkgs, lib, ... }:

let
  cfg = config.tools.kind;
in
{
  options.tools.kind = {
    enable = lib.mkEnableOption "Kubernetes IN Docker - local clusters for testing Kubernetes";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kind;
      defaultText = lib.literalExpression "pkgs.kind";
      description = "The kind package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    env.KIND_CLUSTER_NAME = builtins.baseNameOf config.env.DEVENV_ROOT;

    versions.exec = "${cfg.package}/bin/kind version";
  };
}
