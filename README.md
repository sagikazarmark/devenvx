# Useful modules for [devenv](https://devenv.sh/)

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

## Usage

TODO

### Usage with flake.parts

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    xdevenv.url = "github:sagikazarmark/xdevenv";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        devenv.shells = {
          default = {

            # Import the module
            imports = [
              inputs.xdevenv.module
            ];
          };
        };
      };
    };
}
```

## License

The project is licensed under the [MIT License](LICENSE).
