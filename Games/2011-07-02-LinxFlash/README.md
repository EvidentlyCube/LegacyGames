# Linx (Flash)

 - **Original Release Date:** July 2, 2011
 - **Status:** Finished
 - **Technology:** Flash
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A unique logical game where your objective is to connect all the same coloured
bases with paths. The paths have a funky characteristic - no two paths of
different colours can intersect. Add to this the pits which no path can cross
and you get a brain-tingling mixture of logical mayhem.

This version combines all three levelsets into one release.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `LMB` ⟶ Draw paths / pickup color
 - `Space` ⟶ Erase paths
 - `S / M` ⟶ Toggle sounds / music
 - `F11 / Alt+Enter` ⟶ Toggle full screen


## Cheats
 - `CLEAR` ⟶ Completes current level


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music:**
    - *">+>tremendous<+<"* by Radoslaw Opalinski (Opal)
    - *"biesiada"* by Piotr Leśnikowski (Lesnik)
    - *"Toilet story 4 u"* by Petter Borling (Ghidorah)
    - *"usteczka"* by Marcin Michalski (Ojciec)
    - *"<-XP1002->"* by Macherman


# Development
## Project Structure
 - `Media/` — Social media and web assets
 - `Source_AS3/` — The <GAME / PROTOTYPE>'s source files
 - `SWF/` — A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win.bat` — A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` — A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added full screen toggling
 - Removed network services & ads
 - Bundled all three levelsets into one SWF


## Links
 - Newgrounds link - https://www.newgrounds.com/portal/view/573738


## License
See the appropriate `LICENSE.txt` files.