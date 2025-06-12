nix
{
  description = "My Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    devShells.default = nixpkgs.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      pkgs.mkShell {
        packages = [
          pkgs.jdk17
          pkgs.unzip
          pkgs.cmake
          pkgs.doas-sudo-shim
          pkgs.pkg-config
          pkgs.ninja
          pkgs.gcc
          pkgs.gtk3
          pkgs.clang
        ];
      }
    );
  };
}
