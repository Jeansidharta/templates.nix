{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs (nixpkgs.lib.systems.flakeExposed) (
          system:
          f {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      devShells = forAllSystems (
        { pkgs, ... }:
        let
          python = pkgs.python314;
          pythonPkgs = python.pkgs;
        in
        {
          default = pkgs.mkShell {
            venvDir = "./.venv";
            LD_LIBRARY_PATH = pkgs.lib.join ":" [
              # "${pkgs.libgcc.lib}/lib" # Used for numpy
            ];
            buildInputs = [
              pythonPkgs.venvShellHook
              python
              pkgs.pyright
            ];
          };
        }
      );
    };
}