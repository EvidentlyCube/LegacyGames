function Sc_Player_Wall_Jump() {
	var dirp,dirm,dirn,waln,walp,walm;
	dirp=I_Var_Loop(p_dir+1,7)
	dirm=I_Var_Loop(p_dir-1,7)
	walp=ds_grid_get(level,p_x+c_movx[dirp],p_y+c_movy[dirp])
	walm=ds_grid_get(level,p_x+c_movx[dirm],p_y+c_movy[dirm])

	if frac(p_dir/2)=0{walp="";walm=""}
	if walp="x"  && walm="x" {p_dir+=4}
	if walp!="x" && walm!="x"{p_dir+=4}
	if walp!="x" && walm="x" {p_dir+=2}
	if walp="x"  && walm!="x"{p_dir-=2}
	p_dir=I_Var_Loop(p_dir,7)
	p_stat=p_jumppow

	/* The wall jumping algorithm is a bit complicated. There are 5 main ways of bouncing:

	XXXX    XXXX
	../X -> ..pX
	...X -> ./.X
	...X    ...X
	1. Player encounters concave corridor. He will  turn 180 degrees

	..XX    ..XX
	..XX -> ..XX
	./.. -> .p..
	....    /...
	2. Player Encounters convex corridor. He will turn 180 degrees.

	XXXX    XXXX | ...X    ...X
	./.. -> .p.. | ..\X -> ..pX
	.... -> ..\. | ...X -> ./.X
	....    .... | ...X    ...X
	3,4. Player Encounters vertical/horizontal wall - he will bounce 90 degrees depending on the direction he is going,
	and the wall he is going to encounter.

	XXXX    XXXX
	.|.. -> .p.. 
	.... -> .|..
	....    ....
	5. Player encounters pure wall while going orthogonally - he will turn 180 degrees

	/,\,| - Player position + ~direction
	X - Wall
	p - last player position
	*/



}
