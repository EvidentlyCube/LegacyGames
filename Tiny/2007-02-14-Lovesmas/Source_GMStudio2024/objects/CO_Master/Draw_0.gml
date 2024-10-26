draw_set_font(global.font)
draw_set_halign(fa_center)
draw_text(room_width/2,50,string_hash_to_newline(string(floor(global.sc))))
draw_rectangle_color(100,5,700,30,c_black,c_dkgray,c_black,c_dkgray,0)

draw_rectangle_color(400-global.lv*3,5,400+global.lv*3,30,c_red,c_yellow,c_red,c_yellow,0)

