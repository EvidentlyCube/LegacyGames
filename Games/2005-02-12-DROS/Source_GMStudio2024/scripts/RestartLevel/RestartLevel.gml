function smartRoomRestart(){
	if (global.save_buffer != 0) {
		game_load_buffer(global.save_buffer);
	} else {
		room_restart();
	}
}

function saveCheckpoint() {
	clearCheckpoint()
	global.save_buffer = buffer_create(1024, buffer_grow, 1);
	game_save_buffer(global.save_buffer);
}

function clearCheckpoint() {
	if global.save_buffer != 0 {
		buffer_delete(global.save_buffer)
	}
	global.save_buffer = 0;
}

function getCheckpointSavePath() {
	return program_directory + "/checkpoint.save";
}

function startGameFromFrozenIfPossible() {
	// Freezing was discarded
	ini_open(program_directory + "/save.ini");
	var lastRoom = ini_read_string("main","last_room",room_get_name(ROOM_1x2))
	ini_close();
	
	for (var i = 0; i < 999; i++) {
		if (room_exists(i) && room_get_name(i) = lastRoom) {
			room_goto(i);
			return;
		}
	}
	
	room_goto(ROOM_1x2);
}

function storeFreeze() {
	// ignore
}

function getFreezeSavePath() {
	//ignore
}