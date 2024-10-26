// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function registry_write_string(_name, _str){
	var _file = file_text_open_write(_name + ".reg");
	file_text_write_string(_file, _str);
	file_text_close(_file);
}