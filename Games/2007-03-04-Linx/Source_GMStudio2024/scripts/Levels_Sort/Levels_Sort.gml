function Levels_Sort() {
	file=file_text_open_read(working_directory+"/levels/base.txt")
	dss=ds_list_create()
	while !file_text_eof(file){
		ds_list_add(
			dss,
			string_replace_all(
				string_replace_all(file_text_read_string(file)," ","$"),
				"]",
				"#"
			)
		)
		file_text_readln(file)
	}
	ds_list_sort(dss,1)
	file_text_close(file)
	file_delete(working_directory+"/levels/base.txt")
	file=file_text_open_write(working_directory+"/levels/base.txt")
	while ds_list_size(dss)>0{
	file_text_write_string(file,string_replace_all(string_replace_all(ds_list_find_value(dss,0),"$"," "),"#","]"))
	ds_list_delete(dss,0)
	file_text_writeln(file)
	}
	file_text_close(file)



}
