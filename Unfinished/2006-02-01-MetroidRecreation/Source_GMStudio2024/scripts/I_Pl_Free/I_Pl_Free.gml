function I_Pl_Free(argument0, argument1) {
	var tmp_lev, tmp_en; //Temporary variables used to prevent the scripts from being too long 
	tmp_lev=ds_grid_get(level,p_x+argument0,p_y+argument1) //xyz=what lies on the tile which player tries to enter
	tmp_en=ds_grid_get(lev_e,p_x+argument0,p_y+argument1)
	/*Moving while in standing mode
	Checks if you are in Standing mode. If yes then checks if the tile you are trying to enter is a floor AND if there
	is no enemy occupying this tile. It returns the value:
	0 - if the tile isn't a floor OR an enemy is occupying that tile
	1 - if the tile IS a floor AND there is no enemy occupying that tile*/

	if p_mode=0{if tmp_lev="." && tmp_en=-1{return(1)} else {return(0)}}
	/*Checks if you are in Ball mode. If yes then checks if the tile you are trying to enter is a floor OR low floor AND if there
	is no enemy occupying this tile. It returns the value:
	0 - if the tile isn't a floor/low floor OR an enemy is occupying that tile
	1 - if the tile IS a floor/low floor AND there is no enemy occupying that tile*/

	if p_mode=1{if tmp_lev="o" or tmp_lev="." && tmp_en=-1{return (1)} else {return (0)}}



}
