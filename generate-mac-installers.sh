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
./bin/requests-externalizer-mac-arm64=/Library/requests-externalizer/requests-externalizer \
./resources/manifest-mac.json=/Library/Google/Chrome/NativeMessagingHosts/es.requests.externalizer.json \
./resources/manifest-mac.json="/Library/Application Support/Chromium/NativeMessagingHosts/es.requests.externalizer.json" \
./resources/manifest-mac.json="/Library/Application Support/Mozilla/NativeMessagingHosts/es.requests.externalizer.json"


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
./bin/requests-externalizer-mac-x64=/Library/requests-externalizer/requests-externalizer \
./resources/manifest-mac.json=/Library/Google/Chrome/NativeMessagingHosts/es.requests.externalizer.json \
./resources/manifest-mac.json="/Library/Application Support/Chromium/NativeMessagingHosts/es.requests.externalizer.json" \
./resources/manifest-mac.json="/Library/Application Support/Mozilla/NativeMessagingHosts/es.requests.externalizer.json"