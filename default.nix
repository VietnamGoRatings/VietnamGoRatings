{ nixpkgs ? import <nixpkgs> {  } }:
with nixpkgs;
let

  pkgs = [
    yarn
    nodejs
    ruby_2_7.devEnv
    libxml2
    lzma
    sqlite
    libffi
  ];

in
  nixpkgs.stdenv.mkDerivation {
    name = "env";
    buildInputs = pkgs;
  }
