function Toggle_Door(argument0) {
	with (DoorCl){
	 if type=argument0{
	  var a;
	  a=instance_create(x,y,DoorOp)
	  a.type=type
	  a.image_index=image_index
	  a.image_speed=0
	  a.b=1
	  instance_destroy()
	 }
	}

	with (DoorOp){
	 if type=argument0 && b=0{
	  var a;
	  a=instance_create(x,y,DoorCl)
	  a.type=type
	  a.image_index=image_index
	  a.image_speed=0
	  instance_destroy()
	 }
	}

	with (DoorOp){b=0}



}
