function Buttons_Get_Special(argument0, argument1) {
	with(argument0){
	    file=file_bin_open("./levels/lev"+string(global.level)+"_"+string(argument1)+".kis",2)
    
	    type=file_bin_read_byte(file)
	    actions=file_bin_read_byte(file)
	    var num;
	    num=0
	    repeat(actions){
	        a_type[num]=file_bin_read_byte(file)
	        a_mode[num]=file_bin_read_byte(file)
	        a_t_x[num]=file_bin_read_byte(file)
	        a_t_y[num]=file_bin_read_byte(file)
	        a_t_z[num]=file_bin_read_byte(file)
	        num+=1
	    }
	    file_bin_close(file)
	}



}
