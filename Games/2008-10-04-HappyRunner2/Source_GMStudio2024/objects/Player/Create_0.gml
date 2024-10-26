dir=1
b=0
xmove=0
ymove=0
kl=0
kr=0
diring=0
global.timer=0
screen_redraw()
draw_set_alpha(0.5);
    draw_set_color(c_blue)
    draw_rectangle(0,room_height/2-60,room_width,room_height/2+60,0)
    draw_set_blend_mode(bm_add)
    draw_rectangle_color(0,room_height/2-80,room_width,room_height/2-60,c_black,c_black,c_blue,c_blue,0)
    draw_rectangle_color(0,room_height/2+60,room_width,room_height/2+80,c_blue,c_blue,c_black,c_black,0)
    draw_set_blend_mode(bm_normal)
    draw_set_alpha(1);
    
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(room_width/2+2,room_height/2-48,string_hash_to_newline("##Press \"SPACE\" to start."));
    draw_set_color(c_white);
    draw_text(room_width/2,room_height/2-50,string_hash_to_newline("##Press \"SPACE\" to start."));
    draw_set_halign(fa_left);
    
    

screen_refresh()
while(x=x){
keyboard_wait()
if keyboard_check_pressed(vk_space){break}
}

