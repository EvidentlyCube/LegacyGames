function Open_Door(argument0) {
	with (DoorCl){
	 if type=argument0{
	  var a;
	  a=instance_create(x,y,DoorOp)
	  a.type=type
	  a.image_index=image_index
	  a.image_speed=0
	  instance_destroy()
	 }
	}



}
