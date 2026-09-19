#!/usr/bin/env bash
set -e
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MC_DIR="$ROOT/mcdata"
GAME_DIR="$MC_DIR"
ASSETS_DIR="$MC_DIR/assets"
NATIVES_DIR="$MC_DIR/natives/1.8.9"
VERSION="1.8.9"
ASSETS_INDEX="1.8"
WIDTH=930
HEIGHT=540
JAVA_BIN="${JAVA_BIN:-java}"

printf '\033[0;32mWelcome to NanoMC!\033[0m\n'
printf 'Minecraft %s\n\n' "$VERSION"

[[ -d "$MC_DIR" ]] || { echo "[ERROR] mcdata directory not found."; exit 1; }
command -v "$JAVA_BIN" >/dev/null 2>&1 || { echo "[ERROR] Java was not found. Set JAVA_BIN if needed."; exit 1; }
[[ -d "$NATIVES_DIR" ]] || { echo "[ERROR] Native libraries not found: $NATIVES_DIR"; exit 1; }

read -r -p "Username: " PLAYER_NAME
PLAYER_NAME="${PLAYER_NAME:-Player}"

CLASSPATH=""
while IFS= read -r -d '' jar; do
 if [[ -z "$CLASSPATH" ]]; then CLASSPATH="$jar"; else CLASSPATH="$CLASSPATH:$jar"; fi
done < <(find "$MC_DIR/libraries" -type f -name '*.jar' -print0)

VERSION_JAR="$MC_DIR/versions/$VERSION/$VERSION.jar"
[[ -f "$VERSION_JAR" ]] || { echo "[ERROR] Minecraft $VERSION jar was not found."; exit 1; }
CLASSPATH="$CLASSPATH:$VERSION_JAR"

cd "$MC_DIR"
exec "$JAVA_BIN" -Xmx2G -Djava.library.path="$NATIVES_DIR" -cp "$CLASSPATH"  net.minecraft.launchwrapper.Launch  --username "$PLAYER_NAME" --version "$VERSION" --accessToken 0 --userProperties '{}'  --gameDir "$GAME_DIR" --assetsDir "$ASSETS_DIR" --assetIndex "$ASSETS_INDEX"  --width "$WIDTH" --height "$HEIGHT"  --tweakClass net.minecraftforge.fml.common.launcher.FMLTweaker
