{
  inputs = { };
  outputs =
    { self }:
    {
      templates = {
        zig = {
          description = "Generic zig template";
          path = ./zig;
        };
        golang = {
          description = "Generic golang template";
          path = ./golang;
        };
        rust = {
          description = "Generic rust template";
          path = ./rust;
        };
        gleam = {
          description = "Generic gleam template";
          path = ./gleam;
        };
        nodejs = {
          description = "Generic nodejs template";
          path = ./nodejs;
        };
        neovim-plugin = {
          description = "Generic neovim plugin template";
          path = ./neovim-plugin;
        };
      };
    };
}
