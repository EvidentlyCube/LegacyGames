inst_3x4_exit_up.ix=608
inst_3x4_exit_up.iy=464
inst_3x4_exit_up.goto=ROOM_3x3

inst_3x4_exit_end.ix=592
inst_3x4_exit_end.iy=128
inst_3x4_exit_end.goto=ROOM_END
ini_open(program_directory + "/save.ini")

show_debug_message("ROOM_1x1: " + string(ini_read_real("main","room-ROOM_1x1",0)));
show_debug_message("ROOM_1x2: " + string(ini_read_real("main","room-ROOM_1x2",0)));
show_debug_message("ROOM_1x3: " + string(ini_read_real("main","room-ROOM_1x3",0)));
show_debug_message("ROOM_2x1: " + string(ini_read_real("main","room-ROOM_2x1",0)));
show_debug_message("ROOM_2x2: " + string(ini_read_real("main","room-ROOM_2x2",0)));
show_debug_message("ROOM_2x3: " + string(ini_read_real("main","room-ROOM_2x3",0)));
show_debug_message("ROOM_3x1: " + string(ini_read_real("main","room-ROOM_3x1",0)));
show_debug_message("ROOM_3x2: " + string(ini_read_real("main","room-ROOM_3x2",0)));
show_debug_message("ROOM_3x3: " + string(ini_read_real("main","room-ROOM_3x3",0)));
show_debug_message("ROOM_4x1: " + string(ini_read_real("main","room-ROOM_4x1",0)));
show_debug_message("ROOM_4x2: " + string(ini_read_real("main","room-ROOM_4x2",0)));
show_debug_message("ROOM_4x3: " + string(ini_read_real("main","room-ROOM_4x3",0)));

if ini_read_real("main","room-ROOM_1x1",0)   !=1
 or ini_read_real("main","room-ROOM_1x2",0) !=1 
 or ini_read_real("main","room-ROOM_1x3",0) !=1 
 or ini_read_real("main","room-ROOM_2x1",0) !=1 
 or ini_read_real("main","room-ROOM_2x2",0) !=1 
 or ini_read_real("main","room-ROOM_2x3",0) !=1 
 or ini_read_real("main","room-ROOM_3x1",0) !=1 
 or ini_read_real("main","room-ROOM_3x2",0) !=1 
 or ini_read_real("main","room-ROOM_3x3",0) !=1 
 or ini_read_real("main","room-ROOM_4x1",0) !=1 
 or ini_read_real("main","room-ROOM_4x2",0) !=1 
 or ini_read_real("main","room-ROOM_4x3",0) !=1 
{
	instance_create(608,80,O_WALL)
}

ini_close()