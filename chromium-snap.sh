#!/bin/sh

APP=chromium

# TEMPORARY DIRECTORY
mkdir -p tmp
cd ./tmp || exit 1

# DOWNLOAD APPIMAGETOOL
if ! test -f ./appimagetool; then
	wget -q https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage -O appimagetool
	chmod a+x ./appimagetool
fi

# CREATE CHROMIUM BROWSER APPIMAGES

_create_chromium_appimage() {
	# DOWNLOAD THE SNAP PACKAGE
	if ! test -f ./*.snap; then
		if wget --version | head -1 | grep -q ' 1.'; then
			wget -q --no-verbose --show-progress --progress=bar "$(curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/chromium --silent | sed 's/\[{/\n/g; s/},{/\n/g' | grep -i "$CHANNEL" | head -1 | sed 's/[()",{} ]/\n/g' | grep "^http")"
		else
			wget "$(curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/chromium --silent | sed 's/\[{/\n/g; s/},{/\n/g' | grep -i "$CHANNEL" | head -1 | sed 's/[()",{} ]/\n/g' | grep "^http")"
		fi
	fi

	# EXTRACT THE SNAP PACKAGE AND CREATE THE APPIMAGE
	unsquashfs -f ./*.snap
	mkdir -p "$APP".AppDir
	VERSION=$(cat ./squashfs-root/snap/*.yaml | grep "^version" | head -1 | cut -c 10-)

	mv ./squashfs-root/etc ./"$APP".AppDir/
	mv ./squashfs-root/lib ./"$APP".AppDir/
	mv ./squashfs-root/usr ./"$APP".AppDir/
	mv ./squashfs-root/*.png ./"$APP".AppDir/
	mv ./squashfs-root/bin/*"$APP"*.desktop ./"$APP".AppDir/
	sed -i 's#/chromium.png#chromium#g' ./"$APP".AppDir/*.desktop

	cat <<-'HEREDOC' >> ./"$APP".AppDir/AppRun
	#!/bin/sh
	HERE="$(dirname "$(readlink -f "${0}")")"
	export UNION_PRELOAD="${HERE}"
	export PATH="${HERE}"/usr/bin/:"${HERE}"/usr/sbin/:"${HERE}"/usr/games/:"${PATH}"
	export LD_LIBRARY_PATH="${HERE}"/usr/lib/:"${HERE}"/usr/lib/i386-linux-gnu/:"${HERE}"/usr/lib/x86_64-linux-gnu/:"${HERE}"/lib/:"${HERE}"/lib/i386-linux-gnu/:"${HERE}"/lib/x86_64-linux-gnu/:"${LD_LIBRARY_PATH}"
	export PYTHONPATH="${HERE}"/usr/share/pyshared/:"${HERE}"/usr/lib/python*/:"${PYTHONPATH}"
	export PYTHONHOME="${HERE}"/usr/:"${HERE}"/usr/lib/python*/
	export XDG_DATA_DIRS="${HERE}"/usr/share/:"${XDG_DATA_DIRS}"
	exec ${HERE}/usr/lib/chromium*/chrome "$@"
	HEREDOC
	chmod a+x ./"$APP".AppDir/AppRun

	ARCH=x86_64 ./appimagetool --comp zstd --mksquashfs-opt -Xcompression-level --mksquashfs-opt 20 \
	-u "gh-releases-zsync|$GITHUB_REPOSITORY_OWNER|Chromium-Web-Browser-appimage|continuous|*x86_64.AppImage.zsync" \
	./"$APP".AppDir Chromium-"$CHANNEL"-"$VERSION"-x86_64.AppImage || exit 1
}

CHANNEL="stable"
mkdir -p "$CHANNEL" && cp ./appimagetool ./"$CHANNEL"/appimagetool && cd "$CHANNEL" || exit 1
_create_chromium_appimage
cd ..
mv ./"$CHANNEL"/*.AppImage* ./

CHANNEL="candidate"
mkdir -p "$CHANNEL" && cp ./appimagetool ./"$CHANNEL"/appimagetool && cd "$CHANNEL" || exit 1
_create_chromium_appimage
cd ..
mv ./"$CHANNEL"/*.AppImage* ./

CHANNEL="beta"
mkdir -p "$CHANNEL" && cp ./appimagetool ./"$CHANNEL"/appimagetool && cd "$CHANNEL" || exit 1
_create_chromium_appimage
cd ..
mv ./"$CHANNEL"/*.AppImage* ./

CHANNEL="edge"
mkdir -p "$CHANNEL" && cp ./appimagetool ./"$CHANNEL"/appimagetool && cd "$CHANNEL" || exit 1
_create_chromium_appimage
cd ..
mv ./"$CHANNEL"/*.AppImage* ./

cd ..
mv ./tmp/*.AppImage* ./
