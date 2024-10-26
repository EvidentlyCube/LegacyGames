function Read_X_X_A(argument0) {
	file_bin_seek(argument0,file_bin_position(argument0)+927);
	var Return;
	Return=file_bin_read_byte(argument0);
	file_bin_seek(argument0,file_bin_position(argument0)-928);
	return(Return);



}
