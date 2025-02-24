cd %~dp0
mogrify -resize 35%% -path %cd%/assets/sheet_src/map/ %cd%/assets/sheet_src/map/scalable_raw/*.png
convert %cd%/assets/sheet_src/map/scalable_raw/map_ribbon_victory2.png -resize 50%% %cd%/assets/sheet_src/map/map_ribbon_victory2.png
cd src.sheet_generator
node tileset_convert.js
call grunt
cd %~dp0