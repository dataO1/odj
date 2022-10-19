{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs-unstable.legacyPackages.${system};
      in
      {
        devShell = with pkgs; with unstable; pkgs.mkShell {

          nativeBuildInputs = [
            meson
            ninja
            pkg-config
            cmake
          ];
          buildInputs = [
            libpulseaudio
            miniaudio
          ];
        };

        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "odj";
          src = pkgs.lib.cleanSource ./.;

          nativeBuildInputs = with pkgs; with unstable;[
            meson
            ninja
            pkg-config
            cmake
            miniaudio
          ];

          buildInputs = with pkgs; with unstable;[
            miniaudio
            libpulseaudio
          ];
        };
      });
}
