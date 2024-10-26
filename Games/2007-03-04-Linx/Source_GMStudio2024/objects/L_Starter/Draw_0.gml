if ix<2000{
if draw<1{
draw_set_color(c_black)
draw_set_alpha(1-draw)
draw_rectangle(0,0,room_width,room_height,0)
draw_set_blend_mode(bm_subtract)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60,c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60,room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60,c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60,room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_set_blend_mode(bm_normal)
}
if draw<0.7{
draw+=0.02
} else {if bla=0{
draw_set_color(c_white)
draw_set_alpha(1)
ix+=(room_width/2-ix)/20
draw_set_font(global.font2)
draw_set_halign(fa_center)
draw_text(ix,room_height/2-30,string_hash_to_newline("Level "+string(global.level)))
draw_set_font(global.font)
draw_text(ix,room_height/2,string_hash_to_newline("\""+global.l_title+"\""))
draw_set_font(global.font2)
draw_text(ix,room_height/2+30,string_hash_to_newline("By "+string(global.l_author))) }
}

if (keyboard_check_pressed(vk_anykey) or mouse_check_button(mb_any)) && ix>room_width/2-3 && ix<room_width/2+3 && bla=0{
bla=1
}

if bla=1{
draw_set_color(c_white)
draw_set_alpha(1)
ix+=(ix-room_width/2)/10+4
draw_set_font(global.font2)
draw_set_halign(fa_center)
draw_text(ix,room_height/2-30,string_hash_to_newline("Level "+string(global.level)))
draw_set_font(global.font)
draw_text(ix,room_height/2,string_hash_to_newline("\""+global.l_title+"\""))
draw_set_font(global.font2)
draw_text(ix,room_height/2+30,string_hash_to_newline("By "+string(global.l_author)))
}
} else {
draw2+=1-draw2/40
if draw2>0.999{
draw+=0.04}
draw_set_color(c_black)
draw_set_alpha(1-draw)
draw_rectangle(0,0,room_width,room_height,0)
draw_set_blend_mode(bm_subtract)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60*(1-draw2/20),c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60*(1-draw2/20),room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60*(1-draw2/20),c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60*(1-draw2/20),room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_set_blend_mode(bm_normal)


if draw2>19.9{Master.diss=0;instance_destroy()}
}
