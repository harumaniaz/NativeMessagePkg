#!/bin/bash

# パス定義
APP_NAME="NativeMessageApp.app"
BUILD_DIR="build"
APP_DIR="$BUILD_DIR/$APP_NAME"
PKG_NAME="NativeMessageApp.pkg"
INSTALL_LOCATION="/Applications"
JSON_SRC="$BUILD_DIR/Chrome/com.yourcompany.nma.json"
RESOURCES_DIR="$APP_DIR/Contents/Resources"

# .app チェック
if [ ! -d "$APP_DIR" ]; then
    echo "❌ ERROR: app not found at $APP_DIR"
    exit 1
fi

# JSON ファイルチェック
if [ ! -f "$JSON_SRC" ]; then
    echo "❌ ERROR: JSON file not found at $JSON_SRC"
    exit 1
fi

# Resourcesディレクトリ作成とJSONコピー
rm -rf "$RESOURCES_DIR"
mkdir -p "$RESOURCES_DIR"
cp "$JSON_SRC" "$RESOURCES_DIR/"

# pkg作成
echo "Building pkg..."
pkgbuild \
  --install-location "$INSTALL_LOCATION" \
  --component "$APP_DIR" \
  --scripts scripts \
  "$PKG_NAME"

echo "✅ Package created: $PKG_NAME"