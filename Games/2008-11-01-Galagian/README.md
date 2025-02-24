# Galagian

 - **Original Release Date:** November 1, 2008
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A wave-based space shooter with automatic upgrades and pretty high difficulty.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Mouse` ⟶ Move
 - `LMB` ⟶ Fire
 - `Space` ⟶ Use Shield
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `LIFE` ⟶ Adds an extra life
 - `ASTEROIDS` ⟶ Toggles asteroids (They were actually added in a later update to the game)
 - `MAXIGUN` ⟶ Sets the maximum Weapon level


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music** ⟶ Unknown


# Development
## Project Structure
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added cheat codes
 - Fixed an ancient bug with uint underflow where a mouse placed to the left or above play area would cause the
  ship to fly to the right and bottom of the screen respectively
 - Barrier enemies can no longer be pushed beyond the screen (which was super annoying and felt time wasting)
 - Asteroid HP scaling was reduced because they became too annoying at later waves


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/467636


## License
See the appropriate `LICENSE.txt` files.