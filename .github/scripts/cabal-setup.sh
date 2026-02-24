set -xeo pipefail

# Print versions
cabal --version
ghc --version

sudo apt-get install -y libtinfo-dev iverilog

cabal v2-update | tee cabal_update_output

# File may exist as part of a dist.tar.zst
if [ ! -f cabal.project.local ]; then
  cp .github/files/cabal.project.local .

  set +u
  if [[ "$WORKAROUND_GHC_MMAP_CRASH" == "yes" ]]; then
    sed -i 's/-workaround-ghc-mmap-crash/+workaround-ghc-mmap-crash/g' cabal.project.local
  fi

  if [[ "$GHC_HEAD" == "yes" ]]; then
    cat .github/files/cabal.project.local.append-HEAD >> cabal.project.local
  fi
  set -u

  # Fix index-state to prevent rebuilds if Hackage changes between build -> test.
  # Note we can't simply set it to a timestamp of "now", as Cabal will error out
  # when its index state is older than what's mentioned in cabal.project(.local).
  most_recent_index_state=$(grep "The index-state is set to" cabal_update_output | grep -E -o '[^ ]+Z.$' | tr -d .)
  sed -i "s/HEAD/${most_recent_index_state}/g" cabal.project.local
fi
