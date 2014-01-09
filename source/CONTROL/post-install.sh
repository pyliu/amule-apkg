#!/bin/sh

export PKG_NAME="aMule"
export PKG_ETC_DIR="$APKG_PKG_DIR/etc"
export PKG_AMULE_SHARED_PATH="/volume1/Download/aMule"

export USER=admin
export GROUP=administrators

case "$APKG_PKG_STATUS" in
		install)
				# create aMule directory if not already existing
				if [ ! -d $PKG_AMULE_SHARED_PATH/Temp ]; then
					applog --level 0 --package "$PKG_NAME" --event "aMule temp directory doesn't exist, it will created"
					mkdir -p $PKG_AMULE_SHARED_PATH/Temp
				else
					applog --level 0 --package "$PKG_NAME" --event "aMule temp directory does already exist"
				fi
				if [ ! -d  $PKG_AMULE_SHARED_PATH/Incoming ]; then
					applog --level 0 --package "$PKG_NAME" --event "aMule incoming directory doesn't exist, it will created"
					mkdir -p $PKG_AMULE_SHARED_PATH/Incoming
				else
					applog --level 0 --package "$PKG_NAME" --event "aMule incoming directory does already exist"
				fi
				chown -R $USER:$GROUP $PKG_AMULE_SHARED_PATH/
				;;
		upgrade)
				cp -af $APKG_TEMP_DIR/* $PKG_ETC_DIR
				;;
		*)
				;;
esac

mkdir -p $PKG_TMP_DIR

exit 0
