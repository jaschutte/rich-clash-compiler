{ pkgs, compilerVersion, package }:
let
  clashPkgs = pkgs."clashPackages-${compilerVersion}";
in
  clashPkgs.shellFor {
    packages = p: [
      package
    ];

    nativeBuildInputs = [
      clashPkgs.cabal-install
      clashPkgs.haskell-language-server

      pkgs.ghdl-llvm
      pkgs.nixpkgs-fmt
      pkgs.symbiyosys
      pkgs.verilator
      pkgs.verilog
      pkgs.yosys
    ];
  }
