function I_Effect_B(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	//I_Effect_B(x,y,x_movement,y_movement,time,sprite,subimage)
	var create;
	create=instance_create(argument0,argument1,Effect_B)
	create.timer=argument4;
	create.sprite_index=argument5;
	create.ix=argument2;
	create.iy=argument3;
	create.image_single=argument6;



}
