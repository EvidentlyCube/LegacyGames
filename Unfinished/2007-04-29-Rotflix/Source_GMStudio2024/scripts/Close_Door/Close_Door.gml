function Close_Door(argument0) {
	with (DoorOp){
	 if type=argument0{
	  var a;
	  a=instance_create(x,y,DoorCl)
	  a.type=type
	  a.image_index=image_index
	  a.image_speed=0
	  instance_destroy()
	 }
	}



}
