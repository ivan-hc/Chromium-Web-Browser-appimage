This repository provides the latest version of Chromium Web Browser:
- From here you can download the script "[chromium-junest.sh](https://github.com/ivan-hc/Chromium-Web-Browser-appimage/blob/main/chromium-junest.sh)" to build on top of [JuNest](https://github.com/fsquillace/junest), the lightweight Arch Linux based distro that runs, without root privileges, on top of any other Linux distro. You can download the AppImage from [here](https://github.com/ivan-hc/Chromium-Web-Browser-appimage/releases/tag/continuous);
- The .deb packages instead are provided by the Security Team of Debian (Oldstable), you can see get more info [here](https://packages.debian.org/oldstable/chromium). Until January 2024 I used this as a base, but the Arch Linux base (via the "ArchImage" project) gave me more guarantees of continuity than Debian. If you prefer Debian base, I recommend you fork this repository and modify the "[workflow run](https://github.com/ivan-hc/Chromium-Web-Browser-appimage/blob/main/.github/workflows/blank.yml)" redirecting it to the "[chromium](https://github.com/ivan-hc/Chromium-Web-Browser-appimage/blob/main/chromium)" script available in this repository.

*NOTE: the 32-bit version for the old i386 architectures is available at [ivan-hc/32-bit-AppImage-packages-database](https://github.com/ivan-hc/32-bit-AppImage-packages-database), download it from [here](https://github.com/ivan-hc/32-bit-AppImage-packages-database/releases/tag/chromium).*

# Troubleshoot
AppImages based on Electron require the kernel to be configured in a certain way to allow for its sandboxing to work as intended (specifically, the kernel needs to be allowed to provide “unprivileged namespaces”). Many distributions come with this configured out of the box (like Ubuntu for instance), but some do not (for example Debian), and the AppImage works only with the `--no-sandbox` option. 

For more, visit https://docs.appimage.org/user-guide/troubleshooting/electron-sandboxing.html

---------------------------------

## Install and update it with ease

I wrote two bash scripts to install and manage the applications: [AM](https://github.com/ivan-hc/AM-Application-Manager) and [AppMan](https://github.com/ivan-hc/AppMan). Their dual existence is based on the needs of the end user.

| [**"AM" Application Manager**](https://github.com/ivan-hc/AM-Application-Manager) |
| -- |
| <sub>***If you want to install system-wide applications on your GNU/Linux distribution in a way that is compatible with [Linux Standard Base](https://refspecs.linuxfoundation.org/lsb.shtml) (all third-party apps must be installed in dedicated directories under `/opt` and their launchers and binaries in `/usr/local/*` ...), just use ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager). This app manager requires root privileges only to install / remove applications, the main advantage of this type of installation is that the same applications will be available to all users of the system.***</sub>
[![Readme](https://img.shields.io/github/stars/ivan-hc/AM-Application-Manager?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AM-Application-Manager/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AM-Application-Manager?label=&style=for-the-badge)](https://github.com/ivan-hc/AM-Application-Manager/blob/main/LICENSE)

| [**"AppMan"**](https://github.com/ivan-hc/AppMan)
| --
| <sub>***If you don't want to put your app manager in a specific path but want to use it portable and want to install / update / manage all your apps locally, download ["AppMan"](https://github.com/ivan-hc/AppMan) instead. With this script you will be able to decide where to install your applications (at the expense of a greater consumption of resources if the system is used by more users). AppMan is portable, all you have to do is write the name of a folder in your `$HOME` where you can install all the applications available in [the "AM" database](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs), and without root privileges.***</sub>
[![Readme](https://img.shields.io/github/stars/ivan-hc/AppMan?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AppMan/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AppMan?label=&style=for-the-badge)](https://github.com/ivan-hc/AppMan/blob/main/LICENSE)
