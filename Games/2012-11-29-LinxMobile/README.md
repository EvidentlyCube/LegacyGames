# Linx Mobile

 - **Original Release Date:** November 6, 2012 (estimated)
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A unique logical game where your objective is to connect all the same coloured
bases with paths. The paths have a funky characteristic - no two paths of
different colours can intersect. Add to this the pits which no path can cross
and you get a brain-tingling mixture of logical mayhem.

This is a version of Linx that was created for mobile devices. It has a lot
of issues which were not present in the released version, see **Development**
for more details.

Update dates of version 1.0.5, according to Google Play Console are:
 - October 29, 2012 - for Linx Lite
 - December 2, 2012 - for Linx

I don't know how exactly those match with the actual release dates.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `LMB` ⟶ Draw / Erase paths


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music:**
    - *">+>tremendous<+<"* by Radoslaw Opalinski (Opal)
    - *"biesiada"* by Piotr Leśnikowski (Lesnik)
    - *"Toilet story 4 u"* by Petter Borling (Ghidorah)
    - *"usteczka"* by Marcin Michalski (Ojciec)
    - *"<-XP1002->"* by Macherman


# Development
The code I had for this project is a mess:

 - At some point after releasing the mobile version I started working on
   a desktop release but it was never finished. As such a lot of the code
   is/was semi working.
 - I did not backup the exact version of the framework used at the time so
   lots of the code in `src.framework/` might not be quite as it should be.
 - Finally, I only had a zip archive of the code without the version history
   so there was no way to rollback the desktop changes and get a working
   project.

This explains all of the bugs that are in this game. It's still playable but
treat it more like a curiosity than a finished product.


## Project Structure
 - `LevelEditor/` ⟶ The project files for the Ogmo Editor that was used to make
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes & Issues
 - At some point the game either had tutorial stages or I was in the middle of
   adding them - there were no tutorial stages in the version of the code I had
   nor there was any clue in the code which would tell me which stages those
   were and how it was to work. So it was removed.
 - The mobile version of the game had pinch to zoom. I attempted to make it
   possible to zoom with mouse wheel but it was horribly broken visually
   and the mouse position was incorrect after zooming. So it was not added.
 - Minimap drawing is broken if you resize the screen.
 - Color blind tiles rendering is broken, you need to resize the game window
   a lot for it to work. correctly.
 - Wildcards tiles are rendered in the wrong position until you resize the game
   window.
 - The game in general behaves wrong when you resize the game window.
 - Completed bases don't display as completed.


## Trivia
 - There was a lite (demo) version of the game released for free on Android and
   iOS.
 - The game was paid but I never earned any money on either Google Play or App
   Store to get a single payout.


## License
See the appropriate `LICENSE.txt` files.