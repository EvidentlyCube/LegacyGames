function I_Effect_A(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {
	//I_Effect_A(x,y,time,alpha,sprite,subimage,xscale,yscale,angle,color,alpha_decrease)

	var create;
	create=instance_create(argument0,argument1,Effect_A)
	create.timer=argument2;
	create.image_alpha=argument3;
	create.sprite_index=argument4;
	create.image_index=argument5;
	create.image_xscale=argument6;
	create.image_yscale=argument7;
	create.image_angle=argument8;
	create.image_blend=argument9;
	create.alpher=argument10;



}
