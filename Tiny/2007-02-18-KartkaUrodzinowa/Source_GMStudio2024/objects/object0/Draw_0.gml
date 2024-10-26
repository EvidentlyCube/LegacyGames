a+=0.03
b+=+sin(a)
draw_me()

tim+=1
if tim=60 && global.tim>0{global.tim-=1;tim=0}

draw_set_font(global.font)
draw_set_halign(fa_center)
draw_set_color(c_white)
draw_text(400,112,string_hash_to_newline(string(floor(global.scr))))
draw_sprite(sprite7,0,304+b,544)
draw_set_halign(fa_left)
draw_text(400+b,544,string_hash_to_newline(string(global.tim)))

