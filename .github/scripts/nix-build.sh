set -uo pipefail

PACKAGE="$1"
CACHE="http://192.168.102.136:9200/public"

PATH_INFO=$(nix path-info "$PACKAGE")
PATH_HASH=$(echo $PATH_INFO | sed -r 's|^/nix/store/(.{32}).*$|\1|')

echo "Getting hash:" &>2
echo $PATH_HASH &>2

# You can query if a package exists in the cache by requesting the following URL:
# HOST:PORT/CACHE/PATH_HASH.narinfo
PATH_EXISTS=$(curl -s -w '%{http_code}\n' "$CACHE/$PATH_HASH.narinfo" -o /dev/null)

if [ "$PATH_EXISTS" -eq 200 ]; then
  # Gracefully exit if a cache has been found
  exit 0
fi

# Else, build!
nix build -L "$PACKAGE" --rebuild
attic push public $(nix path-info "$PACKAGE")
