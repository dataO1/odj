{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.audiorw-src = {
    url = "github:sportdeath/audiorw";
    flake = false;
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, audiorw-src, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs-unstable.legacyPackages.${system};
        audiorw = pkgs.stdenv.mkDerivation rec {
          name = "audiorw";
          src = audiorw-src;

          nativeBuildInputs = [
            pkgs.cmake
            pkgs.ffmpeg # decoding of various file types
          ];
          NIX_CFLAGS_COMPILE = toString [
            "-Wno-error=sign-compare"
          ];
        };
        nativeBuildInputs = with pkgs; with unstable;[
          meson
          ninja
          pkg-config
          cmake
        ];
      in
      {
        devShell = with pkgs; with unstable; pkgs.mkShell {
          inherit nativeBuildInputs;
        };

        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "odj";
          src = pkgs.lib.cleanSource ./.;
          inherit nativeBuildInputs;

          buildInputs = with pkgs; with unstable;[
            tinyalsa # alsa API
            audiorw # high-level audio decoder library using ffmpeg
            rubberband # real-time audio time-stretch library
            ffmpeg # decoding of various file types
          ];
        };
      });
}
