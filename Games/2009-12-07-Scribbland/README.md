# Scribbland

 - **Original Release Date:** December 7, 2009
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Scribbland is an innovative platformer game, where you use only one button to
control the player (namely Left Mouse Button). To make the player move you just
have to click and hold it, while if you want him to jump release said button.
To move in mid-air, quickly release the button and then hold it again.

Your objective is to reach the exit while avoiding hazards and running into
walls. You can play the game either in Easy Mode (You don't get killed when you
run into wall, there are less enemies but the score is lower) or Hard Mode
(Running into wall kills you, there are more enemies but the score is higher).
Compete for the best score and get first on the Hiscore Board!


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Hold LMB/Z/Space` ⟶ Run forward
 - `Release LMB/Z/Space` ⟶ Jump
 - `Q/Escape` ⟶ Exit level
 - `Arrows + Z` ⟶ Move in alt controls
 - `S` ⟶ Toggle sounds
 - `M` ⟶ Toggle music


## Cheats
 - `ARROW` ⟶ Toggle alt controls


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music** ⟶ *"violence!"* by Mathieu Berthaud (Clawz)


# Development
## Project Structure
 - `Media/` ⟶ Social media and web assets
 - `Source_FLA/` ⟶ The game's sources in the form of an `.fla` file
    and other source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added full screen, scaling and quality options
 - Added cheats
 - Removed old sponsor branding
 - Unlocked all levels by default
 - Added alt control scheme


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/520402


## License
See the appropriate `LICENSE.txt` files.