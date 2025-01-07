# Defines all devShells for the flake
{ system, pkgs, inputs }:
let
  dotnet = (with pkgs.dotnetCorePackages;
    # Multiple dotnet sdks can be provided here
    combinePackages [
      sdk_9_0
    ]);
in
{
  default = pkgs.mkShell {
    # These programs be available to the dev shell
    buildInputs = (with pkgs; [
      dotnet
      just
      nixpkgs-fmt
      roslyn-ls
    ]) ++ pkgs.lib.optional pkgs.stdenv.isDarwin [
      pkgs.libiconv
    ];

    # Hook the shell to set custom env vars
    shellHook = ''
    '';
  };
}
