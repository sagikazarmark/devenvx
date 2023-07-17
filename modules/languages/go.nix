{ config, lib, ... }:

let
  cfg = config.languages.go;
in
{
  config = lib.mkIf cfg.enable {
    versions.exec = "${cfg.package}/bin/go version";
  };
}
