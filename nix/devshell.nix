{ pkgs, compilerVersion }:
let
  clashPkgs = pkgs."clashPackages-${compilerVersion}";
in
  clashPkgs.shellFor {
    packages = p: [
      clashPkgs.clash-benchmark
      clashPkgs.clash-cosim
      clashPkgs.clash-ffi
      clashPkgs.clash-ghc
      clashPkgs.clash-lib
      clashPkgs.clash-lib-hedgehog
      clashPkgs.clash-prelude
      clashPkgs.clash-prelude-hedgehog
      clashPkgs.clash-profiling
      clashPkgs.clash-profiling-prepare
      clashPkgs.clash-term
      clashPkgs.clash-testsuite
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
