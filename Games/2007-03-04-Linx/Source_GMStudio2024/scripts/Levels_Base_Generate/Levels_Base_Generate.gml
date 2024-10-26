function Levels_Base_Generate() {
	if global.lb_title!=-1{ds_list_clear(global.lb_title)}
	if global.lb_finish!=-1{ds_list_clear(global.lb_finish)}
	if global.lb_author!=-1{ds_list_clear(global.lb_author)}
	if global.lb_limit!=-1{ds_list_clear(global.lb_limit)}
	if global.lb_level!=-1{ds_list_clear(global.lb_level)}

	global.lb_title=ds_list_create()
	global.lb_finish=ds_list_create()
	global.lb_author=ds_list_create()
	global.lb_limit=ds_list_create()
	global.lb_level=ds_list_create()

	//if !file_exists(working_directory+'./levels/base.txt'){game_end();exit}
	file=file_text_open_read(working_directory+"/levels/base.txt")

	while !file_text_eof(file){
	text=file_text_read_string(file)
	if string_length(text)=262 or string_length(text)=261 {
	if string_length(text)=262 {finish=1} else {finish=0}
	name=string_replace_all(string_copy(text,1,45),"]","")
	author=string_replace_all(string_copy(text,46,45),"]","")
	limit=string_copy(text,91,3)

	ds_list_add(global.lb_title,name)
	ds_list_add(global.lb_finish,finish)
	ds_list_add(global.lb_author,author)
	ds_list_add(global.lb_limit,limit)
	ds_list_add(global.lb_level,string_copy(text,94,168))
	}
	file_text_readln(file)

	}

	file_text_close(file)




}
