# This nix-shell supports macOS and Linux.
# The repository supports direnv (https://direnv.net/). If your IDE supports direnv,
# then you do not need to care about dependencies.

{ pkgs ? import <nixpkgs> {
    overlays = [];
  }
}:
with pkgs;
let
  unstable = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/11cb3517b3af6af300dd6c055aeda73c9bf52c48.tar.gz"; # Get from here: https://github.com/NixOS/nixpkgs/tree/nixos-unstable
    })
    { };
in
(pkgs.mkShell.override {
  stdenv = llvmPackages_16.stdenv;
}) {
  nativeBuildInputs = [
    # Tools
    rustup
    pkgs.cargo-criterion
    unstable.nixpkgs-fmt # To format this file: nixpkgs-fmt *.nix
  ] ++ lib.optionals stdenv.isLinux [
  ];
}
