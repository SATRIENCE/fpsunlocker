This program automatically changes the oof sound in the Roblox Player to any sound you want. Feel free to change the old original oof sound in this project to your own file with the same name and extension.

1. If you want a custom file, delete the ouch.ogg file (this is the old oof sound, feel free to keep it!)
- 1b. Add a new ouch.ogg file to your choosing, make sure the name is ouch.ogg (this is the audio file you want to use, it has to be an ogg file. You can convert an mp3 or whatever you have to an ogg file through online converters. Try this: https://online-audio-converter.com/)
2. Run the batch/sh file.
- 2b. If the shell denies to execute the sh file, run `chmod u+x ./changeoofsound.sh` and execute again
(If it has any errors about file deletion, it'll still work and add the new ouch.ogg file)
3. If you're using **Linux/OpenBSD**, the bash script will attempt to inject the sounds in a `wineprefix`. It will look for Roblox in [Grapejuice's](https://brinkervii.gitlab.io/grapejuice/) wineprefix (`~/.local/share/grapejuice/prefixes/player/drive_c`) and the default wineprefix (`~/.wine/drive_c`).
- 3b. If you have Roblox installed somewhere else, you may have to set `WINE_PATH_OVERRIDE` in the script with Roblox's correct path.

And you're done!
