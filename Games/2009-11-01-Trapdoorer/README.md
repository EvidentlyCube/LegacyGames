# Trapdoorer

 - **Original Release Date:** November 1, 2009
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>

## About
Drop all trapdoors and reach the exit. But there's a twist of buttons, special
floor types, bombs and fragile walls that'll test your thinking skills.

## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`

## Controls
 - `NUMPAD` ⟶ Move
 - `Backspace / U` ⟶ Undo
 - `M` ⟶ Toggle music
 - `S` ⟶ Toggle sounds
 - `P` ⟶ Exit level
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen

## Cheats
 - `TOOT` ⟶ Complete level

## Credits
 - **Music:**
   - *"Omogenic"* by Jaakko Iisalo (Croaker)
   - Authors of other music tracks are unknown

# Development
The original version of the game was very tightly integrated with now defunct
Platogo API. A deep dive into the codebase was required to remove all the
integrations and make the editor, achievements and playing custom levels work
again.

Why did I even do this? Nostalgia, most likely.

## Project Structure
 - `Source_AS3/` ⟶ The <GAME / PROTOTYPE>'s source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates

## Changes from the original
 - Removed all references to Platogo and all online service code
 - Saving music/sound options
 - Made achievements/editor/custom levels work without online services
 - Main Menu: Credits & Ending buttons
 - Editor Level List: Double click to edit
 - Editor: Prevent window stacking by hitting escape multiple times in a row
 - Editor: Can now edit author
 - Editor: No exit confirmation when no changes made
 - Editor: Fixed styling disappearing when editing name/author after you clear the entire field
 - UI: Replaced most error windows with notifications
 - Gameplay: Smoother zoom
 - Gameplay: Smoother scrolling
 - Gameplay: Added unlimited undo

## Trivia
 - Originally included integration with now defunct Platogo API for uploading
   levels, rating and playing custom levels
 - Many levels were made by Roland Ariëns and Roland Berrier from, now defunct,
   "Another Game Studio"

## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/516637

## License
See the appropriate `LICENSE.txt` files.