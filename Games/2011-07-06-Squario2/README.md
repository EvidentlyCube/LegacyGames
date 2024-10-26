# Squario 2

 - **Original Release Date:** July 6, 2011
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A platformer directly based on Super Mario games and a sequel to Squario.
Jump around, fire shots, collect "coins" and get to the end of the stage.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows` ⟶ Move
 - `Z` ⟶ Jump
 - `X` ⟶ Fire
 - `M` ⟶ Toggle music
 - `S` ⟶ Toggle sounds
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `LIFE` ⟶ Add a life
 - `GUARD` ⟶ Toggle invincibility
 - `GOTO` ⟶ Skip to the next level


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
 - Added cheats
 - Added full screen, scaling and quality options
 - Removed ads


## Trivia
 - It seems to be the only Flash project I lost the sources for so I had to
   decompile the SWF from Newgrounds and clean things up which was more work
   than I hoped for.
 - The game was originally licensed/sponsored by now defunct BeeJeux.


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/574089


## License
See the appropriate `LICENSE.txt` files.