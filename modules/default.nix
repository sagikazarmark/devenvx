{ ... }:

let
  # Returns a list of all the entries in a folder
  listEntries = path:
    map (name: path + "/${name}") (builtins.attrNames (builtins.readDir path));
in
{
  imports = [
    ./versions.nix
  ]
  ++ (listEntries ./tools)
  ;
}
