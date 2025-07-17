#!/bin/bash
set -e  # Exit on any error

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "❌ Usage: ./release.sh v1.0.0"
  exit 1
fi

# Check for existing tag
if git rev-parse "$VERSION" >/dev/null 2>&1; then
  echo "⚠️ Tag '$VERSION' already exists."
  read -p "Do you want to overwrite it? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "🔁 Re-tagging version $VERSION..."
    git tag -d "$VERSION"
    git push --delete origin "$VERSION"
  else
    echo "❌ Aborting release."
    exit 1
  fi
fi

# Build bootloader
echo "🔧 Building bootloader..."
(cd bootloader && make clean && make BUILD=release)

# Build app
echo "🔧 Building app..."
(cd app && make clean && make BUILD=release)

# Prepare release output
RELEASE_DIR=release
ZIP_NAME=firmware_${VERSION}.zip
mkdir -p "$RELEASE_DIR"

cp bootloader/dist/default/release/bootloader.hex "$RELEASE_DIR/bootloader_${VERSION}.hex"
cp app/dist/default/release/app.hex "$RELEASE_DIR/app_${VERSION}.hex"

# Create .zip archive
cd "$RELEASE_DIR"
zip -r "../$ZIP_NAME" ./*
cd ..

echo "📦 Created ZIP archive: $ZIP_NAME"

# Commit, tag, push
echo "📂 Committing release artifacts..."
git add .
git commit -am "Release $VERSION"
git tag "$VERSION"
git push origin "$VERSION"

echo "✅ HEX files and ZIP archive ready:"
ls -lh release/
ls -lh "$ZIP_NAME"
