# Requests externalizer native application
<div align="center">
  <img src="https://github.com/user-attachments/assets/426d0782-f3d5-462c-b266-411876378e45" alt="Logo">
</div>

This is the native application counterpart of the [requests externalizer browser extension](https://github.com/Dokkaltek/requests-externalizer). It redirects any request it receives from the browser extension to the default terminal of the OS. 

On windows this would be CMD, on Mac zsh, and on linux bash.

The executables were made with GO so that they are easily 
cross-compiled. For windows you can create an installer using the .iss 
file in the root folder of this project.

## Installation

You can just execute any of the installers in the [releases](https://github.com/Dokkaltek/requests-externalizer-native-app/releases) page.
For windows it auto-detects your architecture, so you don't need to worry about it (64 bits, 32bits and arm64 supported).

The installers were created using GO compiler for the main binary, Innosetup for windows installer, and [FPM packager](https://fpm.readthedocs.io) for linux and mac deb and rpm installers.

### Installation for non supported systems

For any other one system that isn't in the releases page you can install things manually compiling the executable using [GO](https://go.dev/).

After installing go you can compile the executable for your system using:
<pre>go build</pre>

If you need to build for other systems you can check the supported platforms that GO can compile using
<pre>
go tool dist list
</pre>

You can then compile the thing using the variables GOOS for the OS and GOARCH for the architecture.

For example, you can compile for windows from a linux OS using:

<pre>
GOOS=windows go build
</pre>

In the same manner, you can compile for linux on windows using:

<pre>
set GOOS=linux
go build
</pre>

After that you will have to tell the extension where to look for it. You can do that placing a `manifest.json` file in certain places depending on your OS.

The content of the manifest.json file should be something like this:

``` JSON
{
  "name": "es.requests.externalizer",
  "description": "Requests externalizer native app",
  "path": "<wherever-the-path-of-where-you-placed-the-executable-is>",
  "type": "stdio",
  "allowed_origins": ["chrome-extension://jchbbljfgiblghliggjhcbolcncikaoj/"]
}
```

If you want to install on a firefox-based browser you have to change the `allowed_origins` by `allowed_extensions`:

``` JSON
{
    "name": "es.requests.externalizer",
    "description": "Requests externalizer native app",
    "path": "<wherever-the-path-of-where-you-placed-the-executable-is>",
    "type": "stdio",
    "allowed_extensions": ["requests-externalizer@dokkaltek.es"]
}  
```

You can find the location of where you have to place this file [here for chrome/chromium](https://developer.chrome.com/docs/extensions/develop/concepts/native-messaging?#native-messaging-host-location) or [here for firefox](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#manifest_location).

## FAQ

**My antivirus program detected this as a virus. How can I know you don't want to infect me for all my juicy data you monster?!**

This is a common issue with programs compiled with python or GO. You can even see it on [the official GOlang FAQ](https://go.dev/doc/faq#virus).

The only way to solve this would be to sign the binaries, which isn't cheap, and I have no reason to do for an open source free program that I'm not getting any revenue from.

**Why not have an installer for each architecture split up for windows?**
The installer is already quite small for the 3 major architectures bundled, so no reason for it. 
If you want to use a different architecture for any reason for the executable you can always compile the binary manually and place the manifest.json on your own following the guidelines on the "installation for non-supported systems" section.
