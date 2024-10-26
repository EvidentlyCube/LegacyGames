# Submuncher

 - **Last modification date:** March 14, 2015
 - **Status:** Abandoned
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Submarine collecting DNA? Avoiding giant fish? Watching out for SPIKES?
SHOOTING MISSILES?! That's Submuncher, where your sub munches on green double
helixes, sometimes even red helixes.

An action game with short stages and high difficulty where precision is
the key.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `WSAD` ⟶ Move
 - `Arrows` ⟶ Fire missiles
 - `Tab` ⟶ Pause


# Development
## Project Structure
 - `LevelEditor/` ⟶ Project files for Ogmo Editor
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player


## Trivia
 - This game is unfinished.
 - It features a bunch of official levels and an even larger bunch of unofficial,
   unfinished ones.
 - All builds are made with `-debug` flag because otherwise the game doesn't
   work and I didn't want to spend the time to figure out the root cause.


## License
See the appropriate `LICENSE.txt` files.