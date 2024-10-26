function Read_X_A_B(argument0) {
	file_bin_seek(argument0,file_bin_position(argument0)+927+928);
	var Return;
	Return=file_bin_read_byte(argument0);
	file_bin_seek(argument0,file_bin_position(argument0)-928-928);
	return(Return);



}
