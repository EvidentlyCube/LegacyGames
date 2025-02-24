# Cloudie

 - **Original Release Date:** September 5, 2011
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A survival game of avoiding clouds.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows` ⟶ Move
 - `M` ⟶ Toggle music


## Credits
- **Music** ⟶ Unknown


# Development
## Project Structure
 - `Media/` ⟶ Social media and web assets
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
 - MochiAds code was removed which can cause problems when building the
   game - it should be easy to fix.


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/579504


## License
See the appropriate `LICENSE.txt` files.