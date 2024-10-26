if mouse_x>0 && mouse_y>0 && mouse_x<800 && mouse_y<725{

crop_vars()
if mode=0{
    room_caption="Draw Level";
    for(y=0;y<29;y+=1){
        for(x=0;x<32;x+=1){
            koko=y*32+x
            draw_items(ds_list_find_value(list_o,koko),x*25,y*25,ds_list_find_value(list_a,koko),ds_list_find_value(list_b,koko),ds_list_find_value(list_c,koko))
        }
    }
    draw_items(item,mouse_x-50,mouse_y+25,varz[0],varz[1],varz[2])
    draw_set_alpha(0.5)
    draw_rectangle_color(mouse_x-25,mouse_y+25,mouse_x+50,mouse_y+50,c_black,c_black,c_black,c_black,0)
    draw_set_alpha(1)
    draw_set_font(font0)
    draw_set_halign(fa_right)
    draw_text_color(mouse_x,mouse_y+35,string_hash_to_newline(string(varz[0])),c_white,c_white,c_white,c_white,1)
    draw_text_color(mouse_x+25,mouse_y+35,string_hash_to_newline(string(varz[1])),c_white,c_white,c_white,c_white,1)
    draw_text_color(mouse_x+50,mouse_y+35,string_hash_to_newline(string(varz[2])),c_white,c_white,c_white,c_white,1)
    draw_rectangle_color(mouse_x-25+varzs*25,mouse_y+25,mouse_x+varzs*25,mouse_y+50,c_white,c_white,c_white,c_white,1)
    draw_set_halign(fa_left)
    
    if keyboard_check_pressed(vk_space){mode=1}
    if keyboard_check_pressed(vk_left){varzs-=1;varzs=abs(varzs mod 3)}
    if keyboard_check_pressed(vk_right){varzs+=1;varzs=abs(varzs mod 3)}
    if keyboard_check_pressed(vk_up){varz[varzs]+=1}
    if keyboard_check_pressed(vk_down){varz[varzs]-=1}
    if keyboard_check_pressed(vk_up) && keyboard_check(vk_shift){varz[varzs]+=9}
    if keyboard_check_pressed(vk_down) && keyboard_check(vk_shift){varz[varzs]-=9}
    if keyboard_check_pressed(vk_backspace){varz[varzs]=0}
    
    if mouse_check_button(mb_left) && ds_list_find_value(list_o,floor(mouse_y/25)*32+floor(mouse_x/25))!=1 && !mouse_check_button(mb_right) && mxy!=floor(mouse_y/25)*25+floor(mouse_x/25)*25+floor(mouse_x/25){
        mxy=floor(mouse_y/25)*25+floor(mouse_x/25)*25+floor(mouse_x/25)
        koko=floor(mouse_y/25)*32+floor(mouse_x/25)
        ds_list_replace(list_o,koko,item)
        ds_list_replace(list_a,koko,varz[0])
        ds_list_replace(list_b,koko,varz[1])
        ds_list_replace(list_c,koko,varz[2])
    } else {mxy=-1}
    
    if mouse_check_button(mb_right) && !mouse_check_button(mb_left){
        koko=floor(mouse_y/25)*32+floor(mouse_x/25)
        ds_list_replace(list_o,koko,0)
        ds_list_replace(list_a,koko,0)
        ds_list_replace(list_b,koko,0)
        ds_list_replace(list_c,koko,0)
    }
}

if mode=1{
    room_caption="Select Item";
    for(y=0;y<8;y+=1){
        for(x=0;x<32;x+=1){
            koko=y*32+x
            draw_items(koko,x*25,y*25,0,0,0)
        }
    }
    
    if mouse_check_button_released(mb_left){
        mode=0
        item=floor(mouse_y/25)*32+floor(mouse_x/25)
    }
}

draw_rectangle_color(floor(mouse_x/25)*25,floor(mouse_y/25)*25,floor(mouse_x/25)*25+24,floor(mouse_y/25)*25+24,c_white,c_white,c_white,c_white,1)

}
