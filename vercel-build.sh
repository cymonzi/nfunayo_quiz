#!/bin/bash
set -e
echo "Downloading Flutter..."
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz
echo "Extracting Flutter..."
tar xf flutter_linux_3.19.6-stable.tar.xz

# Add Flutter to PATH
export PATH="$PWD/flutter/bin:$PATH"

# Fix: Allow git to use the Flutter directory
git config --global --add safe.directory "$PWD/flutter"

echo "Flutter version:"
flutter --version
echo "Enabling web..."
flutter config --enable-web
echo "Getting dependencies..."
flutter pub get
echo "Building web..."
flutter build web
echo "Build finished. Contents of build/web:"
ls -l build/web