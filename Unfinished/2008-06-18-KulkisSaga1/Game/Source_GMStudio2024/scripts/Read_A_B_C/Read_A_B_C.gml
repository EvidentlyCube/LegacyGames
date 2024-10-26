function Read_A_B_C(argument0) {
	file_bin_seek(argument0,file_bin_position(argument0)+927+928+928);
	var Return;
	Return=file_bin_read_byte(argument0);
	file_bin_seek(argument0,file_bin_position(argument0)-928-928-928);
	return(Return);



}
