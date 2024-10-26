# Rock Rush

 - **Original Release Date:** August 16, 2011
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Rock Rush is a clone of the iconic Boulder Dash with a few mechanics taken from
the classic Emerald Mine. There are 5 levelsets available, two of which are
custom made and the rest are exact copies of the levels of the first 3
installments in the original Boulder Dash.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows` ⟶ Move
 - `Z` ⟶ Snap items
 - `R` ⟶ Restart level
 - `1 / 2 / 3` ⟶ Speed up game
 - `Shift + LMB` ⟶ Teleport (with cheat enabled)
 - `S` ⟶ Toggle sounds
 - `M` ⟶ Toggle music
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `POP` ⟶ Add 1 diamond
 - `POIP` ⟶ Add 10 diamonds
 - `POIIP` ⟶ Add 100 diamonds
 - `INVULN` ⟶ Make player invincible
 - `HOPPIN` ⟶ Enable teleport
 - `OFFO` ⟶ Explode around player
 - `TOPPING` ⟶ Complete level


## Credits
 - **Music** ⟶ Unknown
 - **Levels** ⟶ Maurycy Zarzycki [Regular levelset],
    Chris Allcock (Zolyx) [Undervaults levelset],
    Peter Liepa and Chris Gray [Classic 1-3 levelset, from Boulder Dash]


# Development
Originally the 5 levelsets were released as 5 separate "games". For the purpose
of this update I've bundled them all together into one binary.


## Project Structure
 - `Media/` ⟶ Social media and web assets
 - `Source_AS3/` ⟶ The <GAME / PROTOTYPE>'s source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added cheats
 - Added full screen, scaling and quality options
 - Added levelset selector


## Links
 - "Regular" on Newgrounds ⟶ https://www.newgrounds.com/portal/view/577399
 - "Undervaults" on Newgrounds ⟶ https://www.newgrounds.com/portal/view/579428
 - "Classic 1" on Newgrounds ⟶ https://www.newgrounds.com/portal/view/590284
 - "Classic 2" on Newgrounds ⟶ https://www.newgrounds.com/portal/view/602355
 - "Classic 3" on Newgrounds ⟶ https://www.newgrounds.com/portal/view/627789


## License
See the appropriate `LICENSE.txt` files.