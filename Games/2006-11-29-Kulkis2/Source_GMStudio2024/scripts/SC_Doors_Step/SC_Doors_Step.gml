function SC_Doors_Step(argument0, argument1) {
	if opening>0 && opening<global.key+1{
	if Body.movex=0 && Body.movey=0{
	if global.keys[floor(opening-1)]=argument0+1{
	    global.doorop=0
	    instance_destroy()
	    k=instance_create(x,y,SmallExploder)
	    k.sprite_index=argument1
	    k.image_index=0
		k.image_speed=0
	    k=instance_create(x,y,SmallExploder)
	    k.sprite_index=sprite_index
	    k.image_index=0
		k.image_speed=0
	    for (a=0;opening<global.key;opening+=1){
	    global.keys[opening-1]=global.keys[opening]
	    }
	    global.key-=1
	    exit
	}
	opening+=0.1
	global.doorop=opening
	}else {opening=0}
	} else {opening=0}



}
