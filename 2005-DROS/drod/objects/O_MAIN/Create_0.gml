a = room
room_name = room_get_name(room)
ini_open(program_directory + "/save.ini")
global.completed = round(ini_read_real("main", "room-" + room_name, 0))

O_PLAYER.x = ini_read_real("main","last_x",O_PLAYER.x)
O_PLAYER.y = ini_read_real("main","last_y",O_PLAYER.y)
O_WEAPON.dir = ini_read_real("main","last_o",0)

if global.completed != 1 {
	with (all) {
		kill = 0;
	}
}
ini_close()
