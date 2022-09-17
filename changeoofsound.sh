#! /bin/bash

SOUND=./ouch.ogg
SOUNDS=/Applications/Roblox.app/Contents/Resources/content/sounds

if test -f "$1"; then
	SOUND="$1"
	echo "changeoofsound: using sound $SOUND"
else
	echo "changeoofsound: using default sound $SOUND"
fi

if test -d "$SOUNDS"; then
	if test -f "$SOUND"; then
		echo "changeoofsound: mv $SOUND to ${SOUNDS}/ouch.ogg"
		if test -f "${SOUNDS}/ouch.ogg"; then
			mv "${SOUNDS}/ouch.ogg" "./old_ouch.ogg"
		fi
		mv "$SOUND" "${SOUNDS}/ouch.ogg"
		echo "changeoofsound: mv $SOUND to ${SOUNDS}/ouch.ogg complete"
	else
		echo "changeoofsound: no such file: $SOUND"
	fi
else
	echo "changeoofsound: no such directory: $SOUNDS"
fi