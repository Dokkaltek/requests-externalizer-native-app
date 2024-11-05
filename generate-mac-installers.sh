#!/usr/bin/env bash

# -----------------------
# DEB packages for mac
# -----------------------

# Mac ARM64
fpm -s dir -t osxpkg -p requests-externalizer-mac-arm64.pkg \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=~/.config/google-chrome/NativeMessagingHosts/es.requests.externalizer.json \
./resources/manifest-linux.json=~/.config/chromium/NativeMessagingHosts/es.requests.externalizer.json

# Mac x64
fpm -s dir -t osxpkg -p requests-externalizer-mac-x64.pkg \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture amd64 \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=~/.config/google-chrome/NativeMessagingHosts/es.requests.externalizer.json \
./resources/manifest-linux.json=~/.config/chromium/NativeMessagingHosts/es.requests.externalizer.json