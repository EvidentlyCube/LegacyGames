# Evader

 - **Original Release Date:** November 11, 2007
 - **Status:** Abandoned game prototype
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
An unfinished prototype of a turn based puzzle game, inspired by DROD. It was
my introduction to Flash development.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Numpad` ⟶ Move


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


## License
See the appropriate `LICENSE.txt` files.