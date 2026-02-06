{ pkgs }:
compilerVersion:
let
  clashPkgs = pkgs."clashPackages-${compilerVersion}";
in
[
  {
    name = "prelude-${compilerVersion}";
    value = clashPkgs.shellFor {
      packages = p: [
        p.clash-prelude
      ];
      nativeBuildInputs = [
        clashPkgs.cabal-install
      ];
    };
  }
  {
    name = "lib-${compilerVersion}";
    value = clashPkgs.shellFor {
      packages = p: [
        p.clash-lib
      ];
      nativeBuildInputs = [
        clashPkgs.cabal-install
      ];
    };
  }
  {
    name = "cosim-${compilerVersion}";
    value = clashPkgs.shellFor {
      packages = p: [
        clashPkgs.clash-cosim
      ];
      nativeBuildInputs = [
        clashPkgs.cabal-install
        pkgs.iverilog
      ];
    };
  }
  {
    name = "ffi-${compilerVersion}";
    value = clashPkgs.shellFor {
      packages = p: [
        p.clash-ffi
      ];
      nativeBuildInputs = [
        clashPkgs.cabal-install
      ];
    };
  }
  {
    name = "testsuite-${compilerVersion}";
    value = clashPkgs.shellFor {
      packages = p: [
        p.clash-testsuite
      ];
      nativeBuildInputs = [
        clashPkgs.cabal-install

        pkgs.gcc
        pkgs.z3
        pkgs.ghdl-llvm
        pkgs.symbiyosys
        pkgs.verilator
        pkgs.verilog
        pkgs.yosys
      ];
    };
  }
  # {
  #   name = "testsuite-${compilerVersion}";
  #   value = pkgs.mkShell {
  #     packages = [
  #       clashPkgs.clash-testsuite
  #       clashPkgs.cabal-install
  #
  #       pkgs.gcc
  #       pkgs.z3
  #       pkgs.ghdl-llvm
  #       pkgs.symbiyosys
  #       pkgs.verilator
  #       pkgs.verilog
  #       pkgs.yosys
  #     ];
  #   };
  # }
]
