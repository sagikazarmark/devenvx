{ config, lib, ... }:

let
  cfg = config.services.vault;
in
{
  config = lib.mkIf cfg.enable {
    versions.exec = "${cfg.package}/bin/vault version";
  };
}
