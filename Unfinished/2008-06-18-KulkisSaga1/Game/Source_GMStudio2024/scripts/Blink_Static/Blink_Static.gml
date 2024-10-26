function Blink_Static() {
	var varia;
	varia=instance_create(x,y,Blinker_Static);
	varia.x=x;
	varia.y=y;
	varia.image_index=image_index;
	varia.depth=depth-1
	varia.sprite_index=sprite_index;
	varia.image_blend=image_blend;
	varia.image_xscale=image_xscale;
	varia.image_yscale=image_yscale;
	varia.image_angle=image_angle;



}
