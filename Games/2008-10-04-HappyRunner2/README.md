# Happy Runner 2

 - **Original Release Date:** October 4, 2008
 - **Status:** Finished
 - **Technology:** Game Maker 6
 - **Download Links:**
   - **Windows + Linux (Wine):** <@FIXME>


## About
A one-button platformer, sequel to Happy Runner.


## How to play the game
 - Game runs on **Windows** and on **Linux** (through Wine)
 - Download the game from the link above
 - **Windows:** Double click `HappyRunner2.exe`
 - **Linux:** Open terminal and type `wine HappyRunner2.exe`


## Controls
 - `Mouse` ⟶ Interact with menu
 - `Space` ⟶ Start level
 - `G (hold)` ⟶ Move
 - `G (release)` ⟶ Jump


## Credits
 - **Music:** *"zoolook"* by Dalezy


# Development
The project does not compile on modern Game Maker Studio.

Main culprit is start and end of stages which interrupted the game's flow by
creating an infinite loop and calling a function that redrew the screen,
something that's no longer available in modern Game Maker. It would require
more work than I wanted to put into this.

There's also the issue of commenting out SXMS (dll of which is not supported)
and handling the new type of IDs but those are relatively simple things to
change.


## Project Structure
 - `Source_GM6/` ⟶ The original GM6 project files
 - `Source_GMStudio1.4/` ⟶ Conversion of the latest version to GM Studio 1.4
 - `Source_GMStudio2024/` ⟶ Latest version ported to GM Studio 2024
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Trivia
 - I absolutely hate the wall graphics and I can't believe I ever thought
   it's a good idea.


## Links
 - Archived game's page ⟶ http://web.archive.org/web/20081009102022/http://mauft.com/games/happy-runner-2


## License
See the appropriate `LICENSE.txt` files.