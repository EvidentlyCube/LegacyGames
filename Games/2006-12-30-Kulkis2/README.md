# Kulkis II

 - **Original Release Date:** December 30, 2006
 - **Status:** Finished
 - **Technology:** Game Maker 6
 - **Download Links:**
   - **Windows + Linux (Wine):** <@FIXME>


## About
Kulkis II is a top-down action game which is almost exclusively about reflexes
with an occasional puzzle stage. It was my first (real) Game Maker game and can
be considered the beginning of a "second era" of my video game history.

This is my first big game released and my first Game Maker project.


## How to play the game
 - Game runs on **Windows** and on **Linux** (through Wine)
 - Download the game from the link above
 - **Windows:** Double click Kulkis2.exe
 - **Linux Option A:** Right click on Kulkis2.exe and select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `wine Kulkis2.exe`


## Controls
 - `Arrows` ⟶ Move
 - `Enter` ⟶ Enter exit, proceed in menus
 - `Z` ⟶ Spit
 - `X` ⟶ Place bomb
 - `F2` ⟶ Restart level
 - `Escape` ⟶ Return to level selection


## Cheats
 - `KULKIS` ⟶ Unlock all levels
 - `LIFE` ⟶ Add one life
 - `CLEAR` ⟶ Destroy all blocks and gems
 - `SAFE` ⟶ Remove all enemies, crates and make pits safe
 - `TELEPORT` ⟶ Teleport to an exit


## Credits
 - **Music:**
   - **Title Screen** ⟶ "Sunday" by Jakub Skorupa (Shyz)
   - **Level Selection** ⟶ "8th" by Konrad Gmurek (KeyG)
   - **Tutorial Levels** ⟶ "Billie Jean" by Jose Manuel Perez (JosSs)
   - **Easy Levels** ⟶ "Chio Chips" by Marek Kuśmierz (Dakota)
   - **Logical Levels** ⟶ "Binary World" by Marek Kuśmierz (Dakota)
   - **Hard Levels** ⟶ "Angry Humpster" by Karol Kurtyka (Karlos)
   - **Extremal Levels** ⟶ "Bees" by Piotr Leśnikowski (Lesnik)
   - **Ending** ⟶ "Modular Infinitum" by Jose Manuel Perez (JosSs)


# Development
It was a lot of work and a lot of bugs, primarily around surfaces. The most interesting bug
was that the wall-surface was drawn over the entire screen in two stages which I figured
out was because the bottom-left pixel was drawn over.

I wanted to enable toggling full screen and changing window size but the game
caches room graphics into a surface (temporary texture) and those things cause
all surfaces to be cleared. The way the whole thing is coded makes it impossible
to regenerate the texture later so... No full screen toggling and changing
window size.

Beyond that it was mostly just small changes in behavior ⟶ like `draw_set_alpha` apparently
being global and not per-draw causing death by an Eye fading out most of the level's view.


## Project Structure
 - `Source_GM6/` ⟶ The original GM6 project files
 - `Source_GMStudio1.4/` ⟶ Conversion of the latest version to GM Studio 1.4
 - `Source_GMStudio2024/` ⟶ Latest version ported to GM Studio 2024
 - `Source_Graphics/` ⟶ All of the old sources I could find for graphics, includes unused art.
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - New cheat codes were added to replace the original one
 - A new splash at the start of the game
 - Old GM's built-in saving mechanism was replaced with saving to a text file
 - Module musics had to be replaced with MP3's


## Trivia
 - Here are programs that open specific uncommon file extensions:
    - `.RDW` ⟶ Real Draw Pro
    - `.PMD` ⟶ Pro Motion (Cosmigo) project file
    - `.PMP` ⟶ Pro Motion (Cosmigo) project file's metadata
    - `.PSP` ⟶ Paint Shop Pro project file
    - `.PXA` ⟶ Pixia Color Painter


## Links
 - Music tracks are on ⟶ https://www.modules.pl
 - Original release thread on GMClan ⟶ https://forum.gmclan.org/topic/3891-kulkis-ii-zr%C4%99czno%C5%9Bci%C3%B3wka-od-g%C3%B3ry-z-elementami-logicznymi/
 - Link with earliest known date ⟶ http://www.freegamearchive.com:8080/download-games/freeware/logic-games/kulkis-2/14782

## License
See the appropriate `LICENSE.txt` files.
