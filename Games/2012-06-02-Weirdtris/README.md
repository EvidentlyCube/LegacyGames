# Weirdtris

 - **Original Release Date:** Jun 2, 2012
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Weirdtris is a peculiar mash up of tetris and match-3 with some gravity added to
the mix. Destroy all block or just a required amount to complete each level, but
be warned! Think before you place a block, as you might get stuck!


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Left/Right` ⟶ Move the blocks
 - `Down` ⟶ Speed up the blocks
 - `F4` ⟶ Toggle scale mode
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `POP` ⟶ Destroy one random block
 - `BOOM` ⟶ Destroy up to five random blocks
 - `OMIT` ⟶ Skip current stage


## Credits
- **Graphics** ⟶ Aleksander Kowalczyk (Cage)
- **Music** ⟶ Unknown


# Development
## Project Structure
 - `Media/` — Social media and web assets
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
 - Added cheats
 - Removed Mochi Ads


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/596573


## License
See the appropriate `LICENSE.txt` files.