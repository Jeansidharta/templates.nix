{
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    neovim-flake = {
      url = "github:jeansidharta/neovim-flake";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
      neovim-flake,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        plugin_name = "INSERT-PLUGIN-NAME";
        pkgs = nixpkgs.legacyPackages.${system};

        neovim-with-plugins = neovim-flake.packages.${system}.default;
        nvim = neovim-with-plugins.override (prev: {
          plugins = (pkgs.lib.attrsets.filterAttrs (key: value: key != plugin_name) (prev.plugins)) // {
            ${plugin_name} = ./.;
          };
        });
      in
      {
        packages.default = nvim;
        devShell = pkgs.mkShell {
          buildInputs = [
            nvim
            pkgs.lua-language-server
            pkgs.stylua
            pkgs.selene
          ];
        };
      }
    );
}
