function Gamendor() {
	file=file_text_open_write("./settings.txt")
	file_text_write_string(file,string(global.op_path))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_tit))
	file_text_writeln(file)
	file_text_write_string(file,string(global.du))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_fs))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_db))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_cr))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_sot))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_fx))
	file_text_writeln(file)
	file_text_write_string(file,string(global.op_mus))
	file_text_writeln(file)
	file_text_close(file)



}
