# Kulkis Saga I: The Shadowy Prologue

 - **Last Update Date:** June 18, 2006
 - **Status:** Abandoned game prototype
 - **Technology:** Game Maker 6


## About
It was a remake of the original Kulkis I made in 2003 - the titular Kulkis bounces up and down,
changes colors and destroys blocks it hits if the colors match.

This was supposed to feature story, open world traversal, abilities that unlocked new areas.

But the scope was too large and I had no clear goal so the game remained unfinished.


## How to play the prototype
You'll need to build it in GM yourself.


# Development
For better or worse the game was trying to push Game Maker to its limits. Or at least
what I perceived to be GM's limits at the time:

 - Level editor and rooms are loaded from the files.
 - Lots of generative graphics: Each room had a randomly generated wall texture that was
  then masked for empty space. Decorative grass was dynamically drawn as a separate layer,
  each blade a separate draw.
 - State of each room was saved in the savefile so whatever was destroyed or damaged remained
  so.
 - Auto tiling


## Current state
It runs but there are a lot of issues:

 - Hitting a switch crashes the game
 - Moving between rooms doesn't quite work
 - The game overlays the HUD instead of being properly offset
 - At least some of the properties and automations are not working

With some additional work I could probably get it to a state where a proof-of-concept
build could be released but just seeing the game somewhat run again was enough
to satisfy my nostalgia.


## Project Structure
 - `Art/` ⟶ All the graphics and screenshots I could find from the project
 - `Editors/` — Four editors for creating separate aspects of the game
 - `Game/` ⟶ The game itself as well as some older versions in the original format
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates

Each of the editors and game have this structure nested inside:
 - `Source_GM6/` ⟶ The original GM6 project files
 - `Source_GMStudio1.4/` ⟶ Conversion of the latest version to GM Studio 1.4
 - `Source_GMStudio2024/` ⟶ Latest version ported to GM Studio 2024


## Changes from the original
The main thing I had to fix to get it to work at all was the fact that GMStudio no longer
allows you to add room creation code as a string that gets evaluated. As such the majority
of `Make_Level` had to be adapted to store things in an array that then gets executed
by another object on creation.


## License
See the appropriate `LICENSE.txt` files.