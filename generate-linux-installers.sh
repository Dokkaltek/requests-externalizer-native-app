#!/usr/bin/env bash

# -----------------------
# DEB packages for linux
# -----------------------

# Linux ARM
fpm -s dir -t deb -p ./installers/requests-externalizer-linux-arm-chrome.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t deb -p ./installers/requests-externalizer-linux-arm-chromium.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux ARM64
fpm -s dir -t deb -p ./installers/requests-externalizer-linux-arm64-chrome.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t deb -p ./installers/requests-externalizer-linux-arm64-chromium.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux x64
fpm -s dir -t deb -p ./installers/requests-externalizer-linux-x64-chrome.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture amd64 \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t deb -p ./installers/requests-externalizer-linux-x64-chromium.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture amd64 \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux x86
fpm -s dir -t deb -p ./installers/requests-externalizer-linux-x86-chrome.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x86=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t deb -p ./installers/requests-externalizer-linux-x86-chromium.deb \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x86=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# -----------------------
# RPM packages for linux
# -----------------------

# Linux ARM
fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-arm-chrome.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json 

fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-arm-chromium.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux ARM64
fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-arm64-chrome.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-arm64-chromium.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-arm64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux x64
fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-x64-chrome.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture amd64 \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-x64-chromium.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture amd64 \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x64=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json

# Linux x86
fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-x86-chrome.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x86=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/opt/chrome/native-messaging-hosts/es.requests.externalizer.json

fpm -s dir -t rpm -p ./installers/requests-externalizer-linux-x86-chromium.rpm \
--name requests-externalizer-native-app \
--license gpl3 \
--version 1.0.0 \
--depends bash \
--architecture all \
--description "The native application for requests externalizer browser extension" \
--url "https://github.com/Dokkaltek/requests-externalizer-native-app" \
--maintainer "Dokkaltek" \
./bin/requests-externalizer-linux-x86=/usr/bin/requests-externalizer \
./resources/manifest-linux.json=/etc/chromium/native-messaging-hosts/es.requests.externalizer.json