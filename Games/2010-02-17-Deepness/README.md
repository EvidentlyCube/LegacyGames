# Deepness

 - **Original Release Date:** February 17, 2010
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
Deepness is a simple platformer shooter, where your objective is to reach the
exit while killing enemies and collecting coins on your way. Being pretty retro
both in terms of graphics and gameplay, you can only shoot in three directions -
left, right and up. Deepness is more of a coffee break game, as it consists of
only ten levels - but the difficulty can make the gameplay span up to 2-3 hours.

I recommend using either `TRIPLE` or `BIGHEAD` cheats to make the game more
enjoyable.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Left/Right` ⟶ Move
 - `Up` ⟶ Aim up
 - `Down` ⟶ Status check
 - `Z` ⟶ Jump
 - `X` ⟶ Fire
 - `S` ⟶ Toggle sounds
 - `M` ⟶ Toggle music
 - `F4` ⟶ Toggle scale modes
 - `F9` ⟶ Toggle quality
 - `F11` ⟶ Toggle fullscreen


## Cheats
 - `THEN` ⟶ Skip to the next level
 - `KILLER` ⟶ Toggle infinite damage
 - `GUARD` ⟶ Toggle invulnerability
 - `TURBO` ⟶ Toggle rapid fire
 - `TRIPLE` ⟶ Toggle triple shoot
 - `BIGHEAD` ⟶ Toggle large bullets
 - `RANGE` ⟶ Toggle increased range
 - `WAVE` ⟶ Toggle ghost bullets


## Credits
- **Music** ⟶ Unknown author
- **Graphics** ⟶ Aleksander Kowalczyk (Cage)


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
 - Added cheats
 - Added auto jump when holding the button
 - Added full screen, scaling and quality options


## Links
 - Newgrounds ⟶ https://www.newgrounds.com/portal/view/527947


## License
See the appropriate `LICENSE.txt` files.