# Monstro: Battle Tactics

 - **Original Release Date:** <FILL>
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project), Adobe AIR
 - **Download Links:**
   - **Windows (Steam):** https://store.steampowered.com/app/369310/Monstro_Battle_Tactics/
   - **Linux (Steam):** https://store.steampowered.com/app/369310/Monstro_Battle_Tactics/


## About
A hybrid of a puzzle game and a tactic RPG sprinkled with dry humor. As the
skygods once again force friendly ancient terror beasts to fight their
human compatriots you control their ranks to fulfill the dastardly wishes of
their captors.

## How to play the game
The game is available on Steam and works both on Windows and Linux.

**Ruffle build:**
While highly discouraged due to very bad performance (the game uses GPU
acceleration which doesn't seem to work great in Ruffle) you can:
  * **Windows:** Run `Source_AS3/scripts/build.cmd` and then run the SWF file that gets put in
    `SWF/` directory
  * **Linux:** Run `Source_AS3/scripts/debug.sh` to build and run the game

**Desktop build:**
On windows run these commands to compile and bundle the game into `Exe/`
directory:
  * `Source_AS3/scripts/steam-01-certificate.bat`
  * `Source_AS3/scripts/steam-02-build.bat`
  * `Source_AS3/scripts/steam-03-bundle.bat`

This generates a Steam-compatible build but you can just run it without Steam
and it will work fine.


## Controls
 - `Mouse` ⟶ Interact with the game
 - `Arrows` / `WSAD` ⟶ Scroll screen
 - `Q` ⟶ Undo last move
 - `Space` ⟶ End turn
 - `F1` ⟶ Show help
 - `F2` ⟶ Show mission objective


## Credits
- **Graphics** ⟶ Aleksander Kowalczyk
- **Music** ⟶ Jesse Valentine
- **SFX** ⟶ Joshua D. Young and Fabio Accardo
- **Voice Acting:**
    - **Intro/Outro** ⟶ Ed Bretten
    - **Unit Voices** ⟶ Siyence McGhee & Yogi Paliwal (Seespace Labs)
- **Fonts:**
    - Eboracum
    - New Rocker
- **Testing:**
    - Alex Diener
    - Aquator
    - Chris Alcock
    - Larrymurk
    - Roger Yates


## Project Structure
 - `Exe/` ⟶ Kept directory for storing a compiled bundle of the game where only
   the `.swf` file is replaced, for easier debugging and testing.
 - `LevelEditor/` ⟶ Project files for Ogmo Editor that were used to create
   the levels in the game
 - `Source_AS3/` ⟶ The game's source files
 - `SWF/` ⟶ Kept directory where the ruffle SWF is compiled into. Due to the
   game's filesize and performance in Ruffle the SWF does not come precompiled
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Links
 - Monstro on Steam ⟶ https://store.steampowered.com/app/369310/Monstro_Battle_Tactics/


## License
See the appropriate `LICENSE.txt` files.