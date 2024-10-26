# Tactic DROD

 - **Original Release Date:** April 1, 2013
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A turn based tactic puzzle game created as an April Fool's joke for Caravel
Games forums.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Mouse` ⟶ Select units, move, attack


## Credits
 - **Graphics** ⟶ Caravel Games
 - **Music** ⟶ Caravel Games


# Development
## Project Structure
 - `LevelEditor/` ⟶ Project files for Ogmo Editor
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ A compiled `.swf` file of the game
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Trivia
 - This game was built on the engine created for Monstro: Battle Tactics,
   another game of mine.
 - I posted about making the conversion on March 25, so 6 days before the
   release. It was mostly a solo effort.
 - On the original release the player score (number of deaths across all 5
   levels, including deaths from restarted attempts) was submitted to the
   leaderboard and they'd also get a link to a faux DROD: The Second Sky
   let's play.


## Links
 - Pre april fools forum post ⟶ https://forum.caravelgames.com/viewtopic.php?TopicID=35387&page=0


## License
See the appropriate `LICENSE.txt` files.