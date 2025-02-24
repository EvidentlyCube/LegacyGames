# Skether Level Maker

 - **Original Creation Date:** March 13, 2010
 - **Status:** Finished
 - **Technology:** Flash (mxmlc project)


## About
A tool for creating levels for Sketcher games.


## How to run the tool
**To run the pre-compiled version:**
 - **Windows:** Double click `play-win.bat`
 - **Linux Option A:** Right click on `play-linux.sh` and
   select *"Run As a Program"*
 - **Linux Option B:** Open terminal and type `./play-linux.sh`

**To use it for level creation:**
 - Replace image in `Source_AS3/assets/image.jpg`
 - Compile the tool using the scripts in `Source_AS3/scripts/`
 - Run it using the steps below


## Controls
 - `Mouse` ⟶ Place and drag points
 - `Delete/D` ⟶ Delete selected point
 - `Arrows` ⟶ Shift the selected point 1 pixel at a time


# Development
## Project Structure
 - `Source_AS3/` ⟶ The tool's source files
 - `SWF/` ⟶ A compiled `.swf` file of the tool
 - `play-win.bat` ⟶ A windows batch file that runs the SWF file in
   a bundled flash player
 - `play-linux.sh` ⟶ A shell script that runs the SWF file in
   a bundled flash player
 - `archive_filelist.txt` ⟶ Contents listing of the archive that contained the
   source code, with file modification dates


## Trivia
 - This tool was used to create levels for Sketcher 2 and Sketcher 3.
 - The creation date is an approximation ⟶ the tool was never released publicly,
   it was only for internal use, so I made an educated guess based on the
   last modified date of the source files.


## License
See the appropriate `LICENSE.txt` files.