draw_me()
draw_set_color(c_white)
switch(global.hihi){
case(0):draw_text(x,y,string_hash_to_newline(string(lev)));break;
case(1):draw_text(x,y,string_hash_to_newline(string(va)));break;
case(2):draw_text(x,y,string_hash_to_newline(string(vb)));break;
case(3):draw_text(x,y,string_hash_to_newline(string(vc)));break;
}
