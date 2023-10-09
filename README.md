This repository provides the latest version of Chromium Web Browser for Debian Oldstable.

The .deb packages are provided by the Security Team you can see get more info at https://packages.debian.org/oldstable/chromium

*NOTE: the 32-bit version for the old i386 architectures is available at [ivan-hc/32-bit-AppImage-packages-database](https://github.com/ivan-hc/32-bit-AppImage-packages-database), download it from [here](https://github.com/ivan-hc/32-bit-AppImage-packages-database/releases/tag/chromium).*

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
