{ config, lib, ... }:

let
  cfg = config.versions;
in
{
  options.versions = {
    enable = lib.mkEnableOption "Print versions when entering a shell";

    exec = lib.mkOption {
      type = types.lines;
      description = "Bash code to execute to print version information.";
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    scripts = {
      versions.exec = cfg.exec;
    };

    enterShell = ''
      versions
    '';
  };
}
