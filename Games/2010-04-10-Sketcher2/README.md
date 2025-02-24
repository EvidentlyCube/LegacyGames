# Sketcher 2

 - **Original Release Date:** April 10, 2010
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Sketcher 2, not unlike its predecessor, is a game going around the idea of
connecting the dots to create a picture. The second installment in the series
primarily features more solid, robust and attractive engine and game play - now
every picture consists of smaller parts which are drawn separately. The graphics
are all kept in the paper and pencil theme, new levels (there are 12 of them, 4
more than before!) are themed around animals. New music and sound effects, menus
and graphics, feeling and enjoyment!


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
- **Music** ⟶ Unknown
- **Photos** ⟶ Unknown


# Development
## Project Structure
 - `Source_FLA/` ⟶ The <GAME / PROTOTYPE>'s sources in the form of an `.fla` file
    and other source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added full screen, scaling and quality options
 - Removed SWF Stats integration


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/532879


## License
See the appropriate `LICENSE.txt` files.