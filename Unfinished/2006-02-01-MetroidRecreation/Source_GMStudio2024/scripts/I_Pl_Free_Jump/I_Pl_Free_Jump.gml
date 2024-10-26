function I_Pl_Free_Jump(argument0, argument1) {
	var tmp_lev, tmp_en; //Temporary variables used to prevent the scripts from being too long 
	tmp_lev=ds_grid_get(level,p_x+argument0,p_y+argument1) //xyz=what lies on the tile which player tries to enter
	tmp_en=ds_grid_get(lev_e,p_x+argument0,p_y+argument1)
	/*JUMPING WHILE BEING IN STANDING MODE
	Tests if you are in standing mode. If yes checks whether the tile you are trying to enter is a pit or 
	floor and if the tile isn't occupied by enemy it returns the value:
	0 - if it isn't such tile OR enemy occupies such tile
	1 - if it is such tile AND enemy isn't occupying such tile*/
	if p_mode=0{if tmp_lev="o" or tmp_lev="." && tmp_en=-1{return(1)} else {return(0)}}
	/*JUMPING WHILE BEING IN BALL MODE
	Tests if you are in BALL mode. If yes checks whether the tile you are trying to enter is a PIT, LOW PIT,
	FLOOR or LOW FLOOR and if the TILE isn't occupied by ENEMY it RETURNS the value: 
	0 - if it isn't such tile OR enemy occupies such tile
	1 - if it is such tile AND enemy isn't occupying such tile*/
	if p_mode=1{if tmp_lev="o" or tmp_lev="O" or tmp_lev="." or tmp_lev="," && tmp_en=-1{return (1)} else {return (0)}}



}
