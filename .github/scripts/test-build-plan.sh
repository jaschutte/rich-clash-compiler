set -xeo pipefail

if [[ "$GHC_HEAD" != "yes" ]]; then
  mv cabal.project.local cabal.project.local.disabled
  [[ ! -f cabal.project.freeze ]] || mv cabal.project.freeze cabal.project.freeze.disabled
  cabal v2-build --dry-run all > /dev/null || (echo Maybe the index-state should be updated?; false)
  mv cabal.project.local.disabled cabal.project.local
  [[ ! -f cabal.project.freeze.disabled ]] || mv cabal.project.freeze.disabled cabal.project.freeze
fi
