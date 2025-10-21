set -uo pipefail

export LC_ALL="C.UTF-8"

cabal v2-update

TESTS="
clash-cosim:test
clash-lib:doctests
clash-lib:unittests
clash-prelude:doctests
clash-prelude:unittests
clash-testsuite
"

for TEST in $TESTS; do
  cabal v2-build $TEST --write-ghc-environment-files=always
done
