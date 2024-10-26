# Flash DROD (King Dugan's Dungeon Lite)

 - **Original Release Date:** July 11, 2012
 - **Status:** 3 out of 6 chapters finished
 - **Technology:** Flash
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
An adventurous puzzler where you can smash monsters and clear dungeons all day!
Kill roaches, smite queens, clip wraithwings, outwit goblins, cut tar. This
is a port/demake of the excellent DROD made in Flash.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win-*.bat`
 - **Linux Option A:** Right click on `play-linux-*.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux-*.sh`


## Controls
 - `Numpad` ⟶ Move & wait
 - `789 UIO JKL` ⟶ Move & wait
 - `Q/W` ⟶ Rotate
 - `Backspace` ⟶ Undo move
 - `R` ⟶ Restart room
 - `=` ⟶ Battle key (do opposite of last move)
 - `X` ⟶ Toggle room lock


# Development
NOTE: The SWFs are made with the original assets but the graphics, sounds
and music were replaced by stubs.

## Project Structure
 - `Source_AS3/` ⟶ The <GAME / PROTOTYPE>'s source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win-*.bat` ⟶ Windows batch files that run an SWF file in
   a bundled flash player
 - `play-linux-*.sh` ⟶ Shell scripts that run an SWF file in
   a bundled flash player


## Changes from the original
 - Caravel Net features were removed (uploading scores, displaying news).
 - Game scales up with the window.


## Trivia
 - The original King Dugan's Dungeon has 25 levels ⟶ the Flash version was meant
   to be released in 6 parts. While holds were created for part 4, 5 and almost
   entirely done for part 6 only first 3 saw the light of the day.
 - A lot of the development was made on an MSI netbook during my commute to and
   from work, a total of 4 hours per day.
 - A JS port of this game is in the works


## Links
 - DROD's homepage ⟶ https://caravelgames.com/Articles/Games.html


## License
See the appropriate `LICENSE.txt` files.