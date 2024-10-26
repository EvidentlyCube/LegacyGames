draw_set_color(c_white)
draw_set_halign(fa_left)
draw_text(94,room_height-16,string_hash_to_newline("001"))
draw_text(163,room_height-16,string_hash_to_newline(string(global.level)))
draw_text(281,room_height-16,string_hash_to_newline(string(global.maxclick)))
draw_set_halign(fa_right)
draw_text(274,room_height-16,string_hash_to_newline(string(global.click)))

if v>0{
draw_sprite_ext(s_001,0,v.x+10,v.y-370,1,1,0,c_white,0.5)
}
