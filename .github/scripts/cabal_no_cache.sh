export GHC_ABI=$(ghc --info | grep "Project Unit Id" | tail -c 7 | cut -c 1-4)
export THREADS=$(.github/scripts/cabal_no_cache.sh)
export CABAL_JOBS=$(.github/scripts/cabal_no_cache.sh)
export CABAL_DIR=$HOME/.cabal
export clash_lib_datadir=$(pwd)/clash-lib/
export clash_cosim_datadir=$(pwd)/clash-cosim/
export
tar -xf dist.tar.zst -C /

# Not all package in cache get packed into dist.tar.zst, so we need to
# regenerate the package database

if [ -z ${GHC_ABI} ]; then
  ghc-pkg recache --package-db=$HOME/.cabal/store/ghc-$GHC_VERSION/package.db;
else
  ghc-pkg recache --package-db=$HOME/.cabal/store/ghc-$GHC_VERSION-$GHC_ABI/package.db;
fi
