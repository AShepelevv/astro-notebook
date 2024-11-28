{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      imports = [
        inputs.devshell.flakeModule
      ];
      perSystem =
        { config, pkgs, ... }:
        let
          texlive = pkgs.callPackage ./nix/texlive.nix { };
        in
        {
          devshells.default = {
            packages = [
              texlive
            ];
            commands = [
              {
                help = "Build the notebook PDF using LaTeX";
                name = "build-notebook";
                command = ''
                  mkdir -p tikz/resource
                  latexmk -pdf -xelatex -shell-escape astro-notebook.tex
                '';
              }
            ];
          };

          packages = {
            default = config.packages.astro-notebook;
            astro-notebook = pkgs.stdenv.mkDerivation {
              name = "astro-notebook";
              src = inputs.self;
              buildInputs = [
                texlive
              ];

              buildPhase = ''
                export XDG_CACHE_HOME="$(mktemp -d)"
                mkdir -p tikz/resource
                latexmk -pdf -xelatex -shell-escape astro-notebook.tex
              '';

              installPhase = ''
                mkdir -p $out
                cp astro-notebook.pdf $out/
              '';
            };
          };
        };
    };
}
