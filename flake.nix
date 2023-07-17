{
  description = "Useful modules for devenv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, flake-utils, devenv }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [ ];
            };

            devenv = devenv.lib.mkShell {
              inherit inputs pkgs;

              modules = [
                self.module
              ];
            };
          };
        }
      ) // {
      module = ./modules;
    };
}
