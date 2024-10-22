# DROS

 - **Alternate Titles:** *"Doomed Roads of Skellhood"* and *"Deadly Rooms of Skell-hat"*
 - **Original Release Date:** *probably* March 2005 (that's the last modified date)
 - **Status:** Abandoned

When I was 14 I've discovered DROD and instantly feel in love with the game. It was my first attempt at creating my own version of DROD, in Game Maker. Unfortunately the original thread in which I published the project was deleted so the only history I have of the project is whatever remains in my memories.

Originally made in Game Maker 6, I've used GM Studio 1.4 and then GM Studio 2024 to prepare this version.

## Changes made

* Debug mode was added that was required for testing
* Saving the last played room was added

Otherwise the game is as-is.

## Conversion efforts

Converting the game from GM6 to modern GM Studio was not a **huge** effort but it was non-trivial. Main issues were caused by the fact that in GM6 objects placed in rooms had numerical IDs which you could refer them to, while modern GM has text identifiers. Because the automatic conversion did not list the changed IDs (or maybe GM6 -> 1.4 had this information and I missed it) it was a lot of manual changes.

There was also one annoying issue with the engine being stricter and detecting a bug in the code where an array got replaced with an integer and then accessed as array again.

## Contents:

 - `drod.GM6` - The original GM6 project files
 - `drod.gmz` - Conversion to GM Studio 1.4
 - `drod/` - Project in GM Studio 2024 that compiles