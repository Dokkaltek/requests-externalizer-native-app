@echo off

:: This makes sure that icons are embeded into the go builds
go-winres make --arch=amd64,386,arm64

:: This builds the binaries
set GOOS=windows
set GOARCH=amd64
go build -o ./bin/requests-externalizer-x64.exe

set GOARCH=386
go build -o ./bin/requests-externalizer-x86.exe

set GOARCH=arm64
go build -o ./bin/requests-externalizer-arm64.exe
