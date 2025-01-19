# Sketcher 3

 - **Original Release Date:** July 24, 2011
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Sketcher 3, not unlike its predecessors, is a game going around the idea of connecting the dots to create a picture. This sequel is themed around vehicles.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Mouse` ⟶ Interact, connect numbers
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage), Maurycy Zarzycki
 - **Photos** ⟶ Unknown
 - **Music** ⟶ Unknown


# Development
## Project Structure
 - `Media/` — Social media and web assets
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


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/575425


## License
See the appropriate `LICENSE.txt` files.