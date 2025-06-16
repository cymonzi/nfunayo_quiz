#!/bin/bash
set -e
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz
tar xf flutter_linux_3.19.6-stable.tar.xz
export PATH="$PWD/flutter/bin:$PATH"
flutter config --enable-web
flutter pub get
flutter build web