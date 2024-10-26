# Cyberix

 - **Original Release Date:** November 24, 2009
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Cyberix is an action-logic game. You control a small, ball-shaped being in its
quest to collect all the items from the level and reach the exit. You will be
faced by many hazards and logic elements (enemies, mines, cannons, arrows,
stoppers, crates, pits and more). The quirk is that whenever you move the
player, he will continue in the direction he moved for as long as it is stopped.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows/WSAD` ⟶ Move
 - `R` ⟶ Restart level
 - `M` ⟶ Toggle music
 - `S` ⟶ Toggle sounds
 - `P` ⟶ Pause menu
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `TOOT` ⟶ Complete level


## Credits
 - **Graphics** ⟶ Aleksander Kowalczyk (Cage)
 - **Music:**
    - *"biofuroxyne"* by Krzysztof Ratecki (Bionic)
    - *"Chill'n'Relax"* by Timm Albers (Chromag)
    - *"D I S T A N C E"* by Rob Doell (Glitch)


# Development
Similar to Trapdoorer there was a lot of work getting rid of the Platogo
integration and restoring the editing/custom level playing functionalities.


## Project Structure
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Removed all network services functionalities
 - Achievements: Works without network services
 - Custom levels: Works without network services
 - Editor: Works without network services
 - Editor: Inputs now allow hitting enter to close
 - A lot of small quality of changes across the board
 - Fixed missing keyboard shortcuts for toggling music/sound effects


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/518967
 - Pacomix 2 on Aminet ⟶ http://de6.aminet.net/game/think/Pacomix2.readme
 - Pacomix 2 on Hall of Light ⟶ https://amiga.abime.net/games/view/pacomix-2


## License
See the appropriate `LICENSE.txt` files.