#!/bin/bash
set -e  # Exit immediately on any error

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
mkdir -p release
cp bootloader/dist/default/release/bootloader.hex release/bootloader_${VERSION}.hex
cp app/dist/default/release/app.hex release/app_${VERSION}.hex

# Stage and commit any modified or new files
echo "📦 Committing release artifacts..."
git add .
git commit -am "Release $VERSION"

# Create a Git tag and push
git tag "$VERSION"
git push origin "$VERSION"

echo "🏷️ Tagged repository with $VERSION"
echo "✅ HEX files are ready in ./release:"
ls -lh release
