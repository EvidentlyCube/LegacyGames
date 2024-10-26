# Notice
I am fully aware this prototype uses Nintendo's assets. I made it 15 years ago and
the reason I want it here is because I want this repository to be a complete
collection of my works and I want the source code to be available.

If you're Nintendo you can reach out to me through me@evidentlycube.com


# Alchymi Mario Engine

 - **Estimated Delivery Date:** December 8, 2009
 - **Status:** Finished
 - **Technology:** Flash (.fla project)


## About
An engine for creating Mario flash games commissioned by Alchymi.
There is no game to play here, just a tiny stage showing off the capabilities
of the engine.

It implements a bunch of the usual Mario features but also has keys
and pushable blocks.

There are a bunch of small visual bugs with fractional positions as well as
a bug where if the dying Mario touches a floating platform he'll get attached
to it and it will take forever for death animation to finish playing.


## How to play the test level
You can download a ZIP archive with the entire game from the links above
or play it with `ruffle` builds bundled with this repository:

 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`


## Controls
 - `Arrows` ⟶ Move
 - `Z` ⟶ Jump
 - `X` ⟶ Fire


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


## License
See the appropriate `LICENSE.txt` files.