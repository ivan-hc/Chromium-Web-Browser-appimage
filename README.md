This repository provides the script to create the latest version from https://launchpad.net/~savoury1 and a daily updated AppImage package ready to be used.

# Troubleshoot
AppImages based on Electron require the kernel to be configured in a certain way to allow for its sandboxing to work as intended (specifically, the kernel needs to be allowed to provide “unprivileged namespaces”). Many distributions come with this configured out of the box (like Ubuntu for instance), but some do not (for example Debian), and the AppImage works only with the `--no-sandbox` option. 

For more, visit https://docs.appimage.org/user-guide/troubleshooting/electron-sandboxing.html

# How to integrate Chromium AppImage into the system
The easier way is to install "AM" on your PC, see [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager) for more.

Alternatively, you can install it this way:

    wget https://raw.githubusercontent.com/ivan-hc/AM-Application-Manager/main/programs/x86_64/chromium
    chmod a+x ./chromium
    sudo ./chromium
The AppImage will be installed in /opt/chromium as `chromium`, near other files.
### Update

    /opt/chromium/AM-updater
### Uninstall

    sudo /opt/chromium/remove

------------------------------------
# About Rob Savoury's PPA  
SITE: https://launchpad.net/~savoury1

This is a collection of PPAs giving significant upgrades for the past 6+ years of Ubuntu (LTS) releases. Popular software here: Blender, Chromium, digiKam, FFmpeg, GIMP, GPG, Inkscape, LibreOffice, mpv, Scribus, Telegram, and VLC.

***"SavOS project 3 year milestones: 20,000 uploads and 20,000 users"***
               https://medium.com/@RobSavoury/bade09fa042e

Fun stats: Over 23,000 uploads since August 2019 of 5,100 unique packages!
(3 Nov 2022) With now 460+ unique packages published for 22.04 Jammy LTS, 1,730+ for 20.04 Focal LTS, and a whole lot extra for Xenial & Bionic LTS!

If software at this site is useful to you then please consider a donation:

***Donations: https://paypal.me/Savoury1 & https://ko-fi.com/Savoury1***

***Also https://patreon.com/Savoury1 & https://liberapay.com/Savoury1***

UPDATE (8 May 2022): See new https://twitter.com/RobSavoury for updates on the many Launchpad PPAs found here, ie. new packages built, bugfixes, etc.

***Bugs: File bug reports @ https://bugs.launchpad.net/SavOS/+filebug***

[ "SavOS" is the project heading for all packages at https://launchpad.net/~savoury1 ]
