{
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        runtimeDeps = [
          pkgs.gleam
          pkgs.rebar3
          pkgs.erlang
        ];
      in
      {

        packages.default = pkgs.writeShellApplication {
          name = "project-name";
          runtimeInputs = runtimeDeps;
          text = "gleam run";
        };
        devShell = pkgs.mkShell {
          buildInputs = runtimeDeps;
        };
      }
    );
}
