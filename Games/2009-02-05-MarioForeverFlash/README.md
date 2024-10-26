# Notice
I am fully aware this game uses Nintendo's assets. I made it 15 years ago and
the reason I want it here is because I want this repository to be a complete
collection of my works and I want the source code to be available.

If you're Nintendo you can reach out to me through me@evidentlycube.com


# Mario Forever Flash

 - **Original Release Date:**
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A flash clone of Nintendo's Mario game, commissioned by Softendo. Jump around,
collect mushrooms and do the usual plumber stuff.


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
 - `S` ⟶ Toggle sounds
 - `M` ⟶ Toggle music
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


# Development
Unlike other projects I chose to not clean up the code of this project at all.
It's exactly as it was 15 years ago from today with the sole exception of
adding the display modes and default fullscreen for better playing.


## Project Structure
 - `LevelEditor/` ⟶ Level editor written in BlitzMax
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added full screen, scaling and quality options


## License
See `LICENSE.txt`.