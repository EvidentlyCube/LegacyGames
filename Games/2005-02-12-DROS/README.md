# <FILL>

 - **Alternate Titles:** *"Doomed Roads of Skellhood"* and *"Deadly Rooms of Skell-hat"*
 - **Original Release Date:** February 12, 2005
 - **Status:** Abandoned
 - **Technology:** Game Maker
 - **Download Links:**
   - **Windows + Linux (Wine):** <@FIXME>


## About
An unfinished puzzle game where you kill monsters and swing your sword.

When I was 14 I've discovered DROD and instantly feel in love with the game. It
was my first attempt at creating my own version of DROD, in Game Maker.


## How to play the game
 - Game runs on **Windows** and on **Linux** (through Wine)
 - Download the game from the link above
 - **Windows:** Double click `DROS.exe`
 - **Linux:** Open terminal and type `wine DROS.exe`


## Controls
 - `Numpad` ⟶ Move & wait
 - `Q/W` ⟶ Swing sword
 - `A/S` ⟶ Rotate second weapon (see CHEATS)
 - `Enter` ⟶ Move to the next room
 - `R` ⟶ Restart room from checkpoint
 - `F2` ⟶ Restart room from start


## Cheats
Only work when you press `D` at the start of the game:

 - LMB ⟶ Teleport to empty title
 - K ⟶ Kill all enemies
 - 1 or 2 ⟶ Change weapon


## Credits
 - **Graphics:** ⟶ Caravel Games
 - **Sound Effects:** ⟶ Caravel Games


# Development
Originally made in Game Maker 6, I've used GM Studio 1.4 and then GM Studio 2024
to prepare this version.

Converting the game from GM6 to modern GM Studio was not a **huge** effort but
it was non-trivial. Main issues were caused by the fact that in GM6 objects
placed in rooms had numerical IDs which could be used in code to access them
while modern GM has text identifiers. Because the automatic conversion did not
list the changed IDs (or maybe GM6 -> 1.4 had this information and I missed it)
I had to reverse engineer those.

There was also one annoying issue with the new editor being stricter and
not liking the fact an integer was accessed like an array.


## Project Structure
 - `Source_GM6/` ⟶ The original GM6 project files
 - `Source_GMStudio1.4/` ⟶ Conversion of the latest version to GM Studio 1.4
 - `Source_GMStudio2024/` ⟶ Latest version ported to GM Studio 2024


## Changes from the original
 - Added debug mode
 - Game now saves the last played room


## Links
 - Original release thread ⟶ https://web.archive.org/web/20050501215855/http://www.drod.net/forum/viewtopic.php?TopicID=5153


## License
See the appropriate `LICENSE.txt` files.