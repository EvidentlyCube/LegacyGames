function Generate_Savefile(savePath) {
	if !file_exists(savePath) {
		var save = file_bin_open(savePath, 2);
		file_bin_write_byte(save, 0);
		file_bin_close(save);
	}
	
	if !variable_global_exists("save"){
		global.save = file_bin_open(savePath,2);
	}
	
	if (file_bin_size(global.save) < 1024) {
		show_debug_message("Regenerating save");
	    file_bin_rewrite(global.save);
	    file_bin_write_byte(global.save,0)
	    file_bin_write_byte(global.save,17)
	    file_bin_write_byte(global.save,0)
	    file_bin_write_byte(global.save,175)
	    repeat (10000-4){
	        file_bin_write_byte(global.save,0)
	    }
	    for(a=0;a<256;a+=1){
	        for(b=0;b<1000;b+=1){
	            file_bin_write_byte(global.save, round(random(254)+1))
	        }
	    }
		file_bin_close(global.save);
		global.save = file_bin_open(savePath, 2);
	}

	file_bin_seek(global.save,0)
	show_debug_message(file_bin_size(global.save));
	global.level=file_bin_read_byte(global.save)
	global.temp_play_x=file_bin_read_byte(global.save)*25
	global.temp_play_y=file_bin_read_byte(global.save)*25
	global.temp_play_spd=(file_bin_read_byte(global.save)-125)/10



}
