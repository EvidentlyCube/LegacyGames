# Kulkis 1.5

 - **Original Release Date:** August 27, 2011
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Navigate through new, larger and even deadlier rooms in this continuation to the
Kulkis story. All you must do is collect the keys in order to open the exit...
but there are still the same coloured blocks to clear before the path is open!
Can you earn top points by collecting all of the gems along the way?


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Left/Right` ⟶ Move
 - `Up/Down` ⟶ Speed up/down
 - `P` ⟶ Open Pause
 - `S` ⟶ Toggle sounds
 - `M` ⟶ Toggle music
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `CLEAR` ⟶ Destroy all blocks
 - `KEY` ⟶ Collect all keys
 - `GUARD` ⟶ Toggle invincibility
 - `EXIT` ⟶ Complete level


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music:**
    - *"sdv6"* by Andrzej Dobrowolski (Grogon)
    - *"sequence line"* by Benni Pedersen (Emax)
    - *"synthmania6"* by Wojciech Panufnik (X-Ceed)


# Development
## Project Structure
 - `LevelEditor/` ⟶ Project files for Ogmo Editor
 - `Media/` ⟶ Social media & web assets
 - `Source_AS3/` ⟶ The <GAME / PROTOTYPE>'s source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added cheat codes
 - Added full screen, scaling and quality options
 - A bunch of bug fixes
 - Increased player speed slightly
 - Shrunk the moving spikes' collision box slightly
 - Made one build of the game where both levelsets can be played


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/578252


## License
See the appropriate `LICENSE.txt` files.