{
  description = "BasisVR/UpmBuilds repo";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs-raw@{ flake-utils, ... }:
    let
      # All systems we may care about evaluating nixpkgs for
      systems = with flake-utils.lib.system; [ x86_64-linux aarch64-linux aarch64-darwin x86_64-darwin ];
      perSystem = (system: rec {
        inputs = inputs-raw;
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            ((import nix/overlays/nixpkgs-unstable.nix) { inherit inputs; })
          ];
          config = {
            # allowUnfree = true;
            permittedInsecurePackages = [
              # Needed for roslyn-ls, see
              # https://github.com/NixOS/nixpkgs/blob/4989a246/pkgs/by-name/ro/roslyn-ls/package.nix#L21
              "dotnet-sdk-6.0.428"
            ];
          };
        };
      });
      # This `s` helper variable caches each system we care about in one spot
      inherit (flake-utils.lib.eachSystem systems (system: { s = perSystem system; })) s;
    in
    # System-specific stuff goes in here, by using the flake-utils helper functions
    flake-utils.lib.eachSystem systems
      (system:
        let
          inherit (s.${system}) pkgs inputs;
        in
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells = import ./nix/devShells.nix { inherit system pkgs inputs; };
        }
      );
}
