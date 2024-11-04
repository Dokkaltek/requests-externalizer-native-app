@echo off

:: This makes sure that icons are embeded into the go builds
go-winres make --arch=amd64,386,arm64

set GOARCH=amd64
set GOOS=windows
go build -o ./bin/requests-externalizer-x64.exe

set GOOS=linux
go build -o ./bin/requests-externalizer-linux-x64

set GOOS=darwin
go build -o ./bin/requests-externalizer-mac-x64

set GOARCH=386
set GOOS=windows
go build -o ./bin/requests-externalizer-x86.exe

set GOOS=linux
go build -o ./bin/requests-externalizer-linux-x86

set GOARCH=arm64
set GOOS=windows
go build -o ./bin/requests-externalizer-arm64.exe

set GOOS=linux
go build -o ./bin/requests-externalizer-linux-arm64

set GOOS=darwin
go build -o ./bin/requests-externalizer-mac-arm64
