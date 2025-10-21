set -uo pipefail

export LC_ALL="C.UTF-8"

cabal v2-update

case "$1" in
  "prelude")
    cabal v2-run clash-prelude:doctests
    cabal v2-run clash-prelude:unittests -- --hide-successes
    ;;
  "lib")
    cabal v2-run clash-lib:doctests
    cabal v2-run clash-lib:unittests -- --hide-successes
    ;;
  "cosim")
    cabal v2-run clash-cosim:test -- --hide-successes
    ;;
  "ffi")
    cabal v2-run clash-ffi:ffi-interface-tests -- --smallcheck-max-count 2000
    ;;
  "testsuite-vhdl")
    # cabal v2-run clash-testsuite -- --hide-successes -p .VHDL --no-modelsim --no-vivado
    clash-testsuite --hide-successes -p .VHDL --no-modelsim --no-vivado
    ;;
  "testsuite-verilog")
    # cabal v2-run clash-testsuite -- --hide-successes -p .Verilog --no-modelsim --no-vivado
    clash-testsuite --hide-successes -p .Verilog --no-modelsim --no-vivado
    ;;
  "testsuite-systemverilog")
    # cabal v2-run clash-testsuite -- --hide-successes -p .SystemVerilog --no-modelsim --no-vivado
    clash-testsuite --hide-successes -p .SystemVerilog --no-modelsim --no-vivado
    ;;
  *)
    echo "Unrecognized test option";
    exit 1;
    ;;
esac
