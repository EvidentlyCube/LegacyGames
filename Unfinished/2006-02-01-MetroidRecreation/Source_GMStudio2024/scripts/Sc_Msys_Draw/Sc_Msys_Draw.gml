function Sc_Msys_Draw() {
	draw_set_font(font1)
	draw_set_color(100)
	msys_temp=msys_cur+1
	for (i=8;i>-1;i-=1){
	msys_temp-=1
	if msys_temp=-1{msys_temp=msys_max-1}
	draw_text(0,0+i*8,string_hash_to_newline(msys_msg[msys_temp]))
	}



}
