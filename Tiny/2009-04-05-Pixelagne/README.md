# Pixelagne

 - **Last Modified Date:** April 5, 2009
 - **Status:** Finished
 - **Technology:** Flash (.fla project)
 - **Download Links:**
   - **Windows:** <@FIXME>
   - **Linux:** <@FIXME>


## About
A set of three tiny games that were embedded on my website at some point in the
past.


## How to play the game
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win-X.bat`
 - **Linux Option A:** Right click on `play-linux-X.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux-X.sh`


# Development
## Project Structure
 - `Source_FLA/` ⟶ The <GAME / PROTOTYPE>'s sources in the form of an `.fla` file
    and other source files
 - `SWF/` ⟶ A compiled `.swf` file of the <GAME / PROTOTYPE>
 - `play-win-X.bat` ⟶ Windows batch files that run the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ Shell scripts that run the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Changes from the original
 - Sitelocking (making a flash game work only when hosted on certain domains)
   was removed.
 - Score submitting and verification was also removed.
 - The HitTest function that I used was additionally broken when the game was
   rescaled so a simpler distance one was used instead.


## License
See the appropriate `LICENSE.txt` files.