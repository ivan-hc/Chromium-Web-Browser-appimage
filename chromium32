#!/bin/sh

APP=chromium

mkdir tmp;
cd tmp;

# DOWNLOADING THE DEPENDENCIES
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-i686.AppImage -O appimagetool
wget https://github.com/ivan-hc/pkg2appimage-32bit/releases/download/continuous/pkg2appimage-i386.AppImage -O pkg2appimage
chmod a+x ./appimagetool ./pkg2appimage

DEBRELEASE="oldstable"
VERSION=$(echo $(wget -q https://packages.debian.org/$DEBRELEASE/i386/chromium/download -O - | grep ".deb" | head -1 | grep -o -P '(?<=chromium_).*(?=_i386)'))

# CREATING THE APPIMAGE: APPDIR FROM A RECIPE...
echo "app: chromium
binpatch: true

ingredients:
  dist: $DEBRELEASE
  package: chromium
  sources:
    - deb http://ftp.debian.org/debian/ $DEBRELEASE main contrib non-free
    - deb http://security.debian.org/$DEBRELEASE-security/ $DEBRELEASE-security main contrib non-free
    - deb http://ftp.debian.org/debian/ $DEBRELEASE-updates main contrib non-free
  script:
    - wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/$(wget -q https://packages.debian.org/$DEBRELEASE/i386/chromium/download -O - | grep Download | head -1 | grep -o -P '(?<=Selection -- ).*(?=</title)')
    - wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/$(wget -q https://packages.debian.org/$DEBRELEASE/i386/chromium-common/download -O - | grep Download | head -1 | grep -o -P '(?<=Selection -- ).*(?=</title)')
    - wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/$(wget -q https://packages.debian.org/$DEBRELEASE/i386/chromium-driver/download -O - | grep Download | head -1 | grep -o -P '(?<=Selection -- ).*(?=</title)')
    - wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/$(wget -q https://packages.debian.org/$DEBRELEASE/all/chromium-l10n/download -O - | grep Download | head -1 | grep -o -P '(?<=Selection -- ).*(?=</title)')
    - wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/$(wget -q https://packages.debian.org/$DEBRELEASE/i386/chromium-sandbox/download -O - | grep Download | head -1 | grep -o -P '(?<=Selection -- ).*(?=</title)')
  packages:
    - chromium" >> recipe.yml;

ARCH=i386 ./pkg2appimage ./recipe.yml;

# ...REPLACING THE EXISTING APPRUN WITH A CUSTOM ONE...
rm -R -f ./$APP/$APP.AppDir/AppRun
cat >> ./$APP/$APP.AppDir/AppRun << 'EOF'
#!/bin/sh
HERE="$(dirname "$(readlink -f "${0}")")"
export UNION_PRELOAD="${HERE}"
export PATH="${HERE}"/usr/bin/:"${HERE}"/usr/sbin/:"${HERE}"/usr/games/:"${PATH}"
export LD_LIBRARY_PATH=/lib/:/lib64/:/lib/x86_64-linux-gnu/:/usr/lib/:"${HERE}"/usr/lib/:"${HERE}"/usr/lib/i386-linux-gnu/:"${HERE}"/usr/lib/x86_64-linux-gnu/:"${HERE}"/lib/:"${HERE}"/lib/i386-linux-gnu/:"${HERE}"/lib/x86_64-linux-gnu/:"${LD_LIBRARY_PATH}"
export PYTHONPATH="${HERE}"/usr/share/pyshared/:"${HERE}"/usr/lib/python*/:"${PYTHONPATH}"
export PYTHONHOME="${HERE}"/usr/:"${HERE}"/usr/lib/python*/
export XDG_DATA_DIRS="${HERE}"/usr/share/:"${XDG_DATA_DIRS}"
exec ${HERE}/usr/lib/chromium/chromium "$@"
EOF
sed -i 's/x86_64/i386/g' ./$APP/$APP.AppDir/AppRun
sed -i 's/64/x32/g' ./$APP/$APP.AppDir/AppRun
chmod a+x ./$APP/$APP.AppDir/AppRun

# ..IMPORT THE DESKTOP FILE TO THE ROOT OF THE APPDIR...
cp ./$APP/$APP.AppDir/usr/share/applications/$APP.desktop ./$APP/$APP.AppDir/$APP.desktop

# ...EXPORT THE APPDIR TO AN APPIMAGE!
ARCH=i386 ./appimagetool -n ./$APP/$APP.AppDir
cd ..;
mv ./tmp/*.AppImage ./Chromium_Web_Browser-$VERSION-i386.AppImage
