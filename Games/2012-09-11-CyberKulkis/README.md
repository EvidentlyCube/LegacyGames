# Cyber Kulkis

 - **Original Release Date:** September 11, 2012
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
An action-puzzler where you need to collect all items and once you move in
a direction you can't stop voluntarily.

This is essentially the same game as Cyber Kulkis except without all the network
features, fewer levels and no achievements. The game was also split into 6
different releases, one for each levelpack from the original Pacomix 2


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows` ⟶ Move
 - `P` ⟶ Pause menu
 - `S / M` ⟶ Toggle music / sound
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `TOOT` ⟶ Complete current level


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music** ⟶ Unknown


# Development

## Project Structure
 - `LevelEditor/` ⟶ The project files for the Ogmo Editor that was used to make
   levels for this game as well as a bunch of unused levels.
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player


## Changes from the original
 - Packed all 6 levelsets into one game.
 - Added full screen toggling


## Trivia
 - It's a direct copy of the mechanics and levels of Pacomix 2, an Amiga game


## Links
 - Pacomix 2 on Hall of Light ⟶ https://amiga.abime.net/games/view/pacomix-2


## License
See the appropriate `LICENSE.txt` files.