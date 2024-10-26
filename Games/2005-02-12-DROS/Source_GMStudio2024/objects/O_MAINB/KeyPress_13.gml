if place_meeting(x,y,O_PLAYER){
	ini_open(program_directory + "/save.ini")
	ini_write_real("main","last_x",ix) 
	ini_write_real("main","last_y",iy)
	ini_write_real("main","last_o",O_WEAPON.dir)
	ini_write_string("main","last_room",room_get_name(goto))
	if global.completed = 1 {
		ini_write_real("main","room-" + room_get_name(room), 1);
	}
	ini_close()
	clearCheckpoint()
	room_goto(goto)
} 

