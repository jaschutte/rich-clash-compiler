set -uo pipefail

PACKAGE="$1"

# Else, build!
nix build -L "$PACKAGE"
attic push public $(nix path-info "$PACKAGE")
