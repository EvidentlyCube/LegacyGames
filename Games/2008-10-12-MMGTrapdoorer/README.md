# Micro Mini Games: Trapdoorer

 - **Original Release Date:** October 12, 2008
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A logical game where you must drop all the trapdoors but jumping off them.
Inspired by Commodre 64 game *"Sensitive"* and the trapdoor element in DROD.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
  - `LMB` ⟶ Place the player/move the player
 - `Numpad` / `QWE AD ZXC` ⟶ Move in 8 directions
 - `F4` ⟶ Toggle scale mode
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `OMIT` ⟶ Skips the current level


## Credits
- **Music** ⟶ *"Omogenic"* by Jaakko Iisalo (Croaker)


# Development
## Project Structure
 - `Editor/` ⟶ Level editor written in Blitz Max
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Added cheat code
 - Added keyboard controls
 - Removed Mochi ads
 - Fixed 8th level missing an exit


## Trivia
 - My first released Flash game.


## Links
 - Page for Commodore 64's "Sensitive" ⟶ https://www.lemon64.com/game/sensitive
 - DROD's homepage ⟶ https://caravelgames.com/Articles/Games.html
 - Game's page on Mauft.com ⟶ https://web.archive.org/web/20081202093917/http://mauft.com/games/mmg—trapdoorer
 - Game's page on Newgrounds ⟶ https://www.newgrounds.com/portal/view/464278


## License
See the appropriate `LICENSE.txt` files.