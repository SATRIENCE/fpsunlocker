#! /bin/bash

SOUND=./ouch.ogg
WINE_PATH_OVERRIDE=false # Wine users, set this if the script isn't able to detect your wineprefix/Roblox installation; it should be the path to Roblox's "Versions" folder

# Mac app path
SOUNDS_MAC=/Applications/Roblox.app/Contents/Resources/content/sounds

# Linux wineprefix path
GRAPEJUICE_WINEPREFIX_PATH=~/.local/share/grapejuice/prefixes/player/drive_c
DEFAULT_WINEPREFIX_PATH=~/.wine/drive_c
# Wine Versions path
WINE_INSTALL_PATH=users/$USER/AppData/Local/Roblox/Versions
# Roblox sound path
SOUNDS_WINE=content/sounds

# Detect the OS the script is running under and set the appropriate flag
OS_FLAG="UNSUPPORTED"
case $OSTYPE in
    "darwin"*) OS_FLAG="MAC";;
	"linux-gnu"*) OS_FLAG="WINE_SUPPORTED";;
	"freebsd"*) OS_FLAG="WINE_SUPPORTED";;
	"win32"*) OS_FLAG="WINDOWS";;
	"cygwin"*) OS_FLAG="UNSUPPORTED";;
	"msys"*) OS_FLAG="UNSUPPORTED";;
esac 

# Decide where the path is and what Roblox platform is present based on the OS flag
SOUND_PATH=""
ROBLOX_PLATFORM=""

DETERMINE_WINEPREFIX_PATH () {
	# Grapejuice is the most commonly used wine wrapper for Roblox, we should check for that first
	if [[ -d $GRAPEJUICE_WINEPREFIX_PATH ]]
	then
		SOUND_PATH=$GRAPEJUICE_WINEPREFIX_PATH
		return 0
	elif [[ -d $DEFAULT_WINEPREFIX_PATH ]] # Grapejuice isn't installed (or its default wineprefix is missing for some reason, check the regular wineprefix instead)
	then
		SOUND_PATH=$DEFAULT_WINEPREFIX_PATH
		return 0
	fi

	echo "changeoofsound: Unable to find a valid wineprefix, try setting the WINE_PATH_OVERRIDE in this script's code" 
	exit 1
}

case $OS_FLAG in
	# Mac has native support for Roblox so it's extremely straightforward
	"MAC")
		SOUND_PATH=$SOUNDS_MAC
		ROBLOX_PLATFORM="MAC"
	;;
	# Linux and freebsd users run Roblox under wine, so the process of figuring out their paths is a little harder
	"WINE_SUPPORTED")
		ROBLOX_PLATFORM="WIN32"

		if $WINE_PATH_OVERRIDE
		then # Bypass searching for a wineprefix (and an install) entirely
			echo "changeoofsound: Using WINE_PATH_OVERRIDE..."
			SOUND_PATH=$WINE_PATH_OVERRIDE
		else
			DETERMINE_WINEPREFIX_PATH

			echo "changeoofsound: Modifying wineprefix $SOUND_PATH"

			SOUND_PATH="$SOUND_PATH/$WINE_INSTALL_PATH"

			if ! [[ -d $SOUND_PATH ]]
			then
				echo "changeoofsound: Unable to find Roblox in wineprefix, is it installed correctly? If it is, try setting the WINE_PATH_OVERRIDE in this script's code"
				exit 1
			fi
		fi
	;;
	# There's little point to this message, but it's better UX than silently erroring or accidentally changing files that shouldn't be changed.
	"WINDOWS") 
		echo "changeoofsound: Windows is not supported by this bash script, please run changeoofsound.bat instead" 
		exit 1
	;;
	# This OS is not supported, inform the user.
	*)
		echo "changeoofsound: Your OS ($OSTYPE) is not supported by changeoofsound"
		exit 1
	;;
esac

# Define the file being copied
if test -f "$1"; then
	SOUND="$1"
	echo "changeoofsound: using sound $SOUND"
else
	echo "changeoofsound: using default sound $SOUND"
fi

function COPY_SOUND () {
	if test -d "$1"; then
		if test -f "$SOUND"; then
			echo "changeoofsound: mv $SOUND to ${1}/ouch.ogg"
			if test -f "${1}/ouch.ogg"; then
				mv "${1}/ouch.ogg" "./old_ouch.ogg"
			fi
			mv "$SOUND" "${1}/ouch.ogg"
			echo "changeoofsound: mv $SOUND to ${1}/ouch.ogg complete"
		else
			echo "changeoofsound: no such file: $SOUND"
		fi
	else
		echo "changeoofsound: no such directory: $1"
	fi
}

case $ROBLOX_PLATFORM in
	"MAC") # Regular behaviour, simply copy files over to the content folder
		COPY_SOUND $SOUND_PATH
	;;
	"WIN32") # Sadly, the win32 version has multiple installs in Versions and we can't tell them apart, so we have to inject the sound in all of them
		echo "changeoofsound: Doing bulk sound change for win32 version..."
		for dir in $SOUND_PATH/*/
		do
			COPY_SOUND "$dir$SOUNDS_WINE"
		done
	;;
esac