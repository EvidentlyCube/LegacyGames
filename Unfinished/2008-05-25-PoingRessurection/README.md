# Poing Ressurection

 - **Last Update Date:** May 25, 2009
 - **Status:** Abandoned game
 - **Technology:** BlitzMax


## About
A clone of an excellent breakout/arcanoid clone from Amiga called Poing. It was
a project where I had a lot of support from Chris Allcock (Zolyx) who has also
made his own clone of this game.

The main difference from regular breakout is that the task is not to destroy all
blocks but destroy the wall at the right side of the room and let the ball pass
through it, effectively entering a next stage. You also wouldn't lose a ball
immediately, instead it would go back to the previous room at super speed giving
you a chance to recover.

I think I had much newer version of the game but it was either lost or I am
misremembering things. There is also a level editor included in this repository
and a tool for drawing on the top matrix dot display.

The current binary doesn't work too well, it's barely playable if at all.


## How to play the game
 - **Windows:** Double click `PoingRessurection-Win32/PoingRessurection.exe`
 - **Linux (through Wine):** Open terminal in the directory
   `PoingRessurection-Win32/` and run the command `wine PoingRessurection.exe`


## Controls
 - `Mouse` ⟶ Control the paddle


# Development
## Project Structure
 - `PoingRessurection-Win32/` ⟶ Contains a compiled binary of the latest version
   of the game along with the graphics and other assets required for it to run
 - `Source_BlitzMax/` ⟶ Source code for the game
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Links
 - Poing on Lemon Amiga ⟶ https://www.lemonamiga.com/games/details.php?id=3839


## License
See LICENSE.txt