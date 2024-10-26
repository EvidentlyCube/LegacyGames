# Linx

 - **Original Release Date:** March 4, 2007
 - **Status:** Finished
 - **Technology:** Game Maker 6
 - **Download Links:**
   - **Windows + Linux (Wine):** <@FIXME>


## About
Linx is a puzzle game that's probably one of my most popular projects. Connect
bases of same color with paths that cannot cross. It featured a level editor and
a neat one-click mechanism to download custom levels from the server.

There was a nasty security vulnerability with the custom level upload feature -
the game connected directly to an unsecured mysql database with a hardcoded
password. I find it amazing no one hacked it before the server went down.


## How to play the game
 - Game runs on **Windows** and on **Linux** (through Wine)
 - Download the game from the link above
 - **Windows:** Double click `Linx.exe`
 - **Linux:** Open terminal and type `wine Linx.exe`


## Controls
 - `LMB` ⟶ Draw / Change Color
 - `RMB` ⟶ Erase
 - `Escape` ⟶ Return to menu


## Credits
- **Graphics** ⟶ Aleksander Kowalczyk (Cage)
- **Level Design** ⟶ Aleksander Kowalczyk (Cage), Maurycy Zarzycki
- **Additional Custom Levels** ⟶ Players
- **Music:**
    - **Title Screen** ⟶ *"Usteczka"* by Marcin Michalski (Ojciec)
    - **Ingame Track #1** ⟶ *"Toilet Story 4 u"* by Petter Borling (Ghidorah)
    - **Ingame Track #1** ⟶ *"XP1002"* by Macherman
    - **Ingame Track #1** ⟶ *"Tremendous"* by Radoslaw Opalinski (Opal)
    - **Editor** ⟶ *"Universal Network 2"* by Strobe & Kmuland
    - **End Game** ⟶ *"Biesiada"* by Piotr Leśnikowski (Lesnik)


# Development
The GM Studio 2024 project files should compile. Making it work was primarily
a matter of disabling SXMS library and other broken functionalities, plus
writing custom faux `registry_*` functions which were originally used to store
information about game completion.


## Project Structure
 - `Source_GM6/` ⟶ The original GM6 project files
 - `Source_GMStudio1.4/` ⟶ Conversion of the latest version to GM Studio 1.4
 - `Source_GMStudio2024/` ⟶ Latest version ported to GM Studio 2024
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - "Always on Top" does nothing as this functionality is not present in
modern GM Studio
 - Level uploading/downloading does not work because the server
   is no longer there
 - Music had to be disabled because the SXMS library no longer works.


## Links
 - Original release post ⟶ https://forum.gmclan.org/topic/4661-linx-gra-logiczna/
 - Music tracks are on ⟶ https://www.modules.pl


## License
See the appropriate `LICENSE.txt` files.