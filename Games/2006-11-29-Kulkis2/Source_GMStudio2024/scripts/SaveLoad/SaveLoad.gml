// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveState() {
	var file = file_text_open_write(getSaveDir());
	for (var i = 0; i < array_length(global.fin); i++) {
		file_text_write_real(file, global.fin[i]);
		file_text_writeln(file);
	}
	file_text_close(file);
}

function LoadState() {
	if !file_exists(getSaveDir()) {
		return;
	}
	var file = file_text_open_read(getSaveDir());
	for (var i = 0; i < array_length(global.fin); i++) {
		if (file_text_eof(file)) {
			break;
		}
		
		var read = file_text_read_real(file);
		global.fin[i] = max(global.fin[i], read);
		
		if (!file_text_eoln(file)) {
			file_text_readln(file);
		}
	}
	file_text_close(file);
}

function getSaveDir() {
	return program_directory + "/save.sav";
}