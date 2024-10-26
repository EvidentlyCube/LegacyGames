draw_background(global.foreground,201,9)

if up=1{
    draw_sprite(s_talka,0,245,58);
    draw_sprite(s_talkb,0,227,32);
}
if down=1{
    draw_sprite(s_talka,0,245,513);
    draw_sprite(s_talkb,0,750,488);
}
if up=1{
    draw_set_halign(fa_left)
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_set_font(global.font)
        draw_text(452,77,string_hash_to_newline(u_author+":"))
        draw_text(452,102,string_hash_to_newline(u_text))
    draw_set_color(c_lime)
    draw_set_alpha(1)
        draw_text(450,75,string_hash_to_newline(u_author+":"))
    draw_set_color(c_white)
        draw_text(450,100,string_hash_to_newline(u_text))
        draw_sprite(u_face,0,227,23)
}

if down=1{
    draw_set_halign(fa_right)
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_set_font(global.font)
        draw_text(748,533,string_hash_to_newline(d_author+":"))
        draw_text(748,558,string_hash_to_newline(d_text))
    draw_set_color(c_lime)
    draw_set_alpha(1)
        draw_text(746,531,string_hash_to_newline(d_author+":"))
    draw_set_color(c_white)
        draw_text(746,556,string_hash_to_newline(d_text))
        draw_sprite(d_face,0,750,488)
}

if string_length(text[current])>0 && side[current]=0{
    u_text+=string_char_at(text[current],0)
    text[current]=string_delete(text[current],1,1)
} else {
    if mouse_check_button_pressed(mb_any) && string_length(text[current])=0{
        u_author=author[current];
        u_face=face[current];
        current+=1
        if current=amount{instance_destroy();exit}
        if side[current]=0{
            u_text=""
        } else {
            d_author=author[current];
            d_face=face[current];
            d_text="";
            down=1
        }
    }
}

if string_length(text[current])>0 && side[current]=1{
    d_text+=string_char_at(text[current],0)
    text[current]=string_delete(text[current],1,1)
} else {
    if mouse_check_button_pressed(mb_any) && string_length(text[current])=0{
        d_author=author[current];
        d_face=face[current];
        current+=1       
        if current=amount{instance_destroy();exit}
        if side[current]=1{
            d_text=""
        } else {
            u_text="";
            up=1
            u_author=author[current];
            u_face=face[current];
        }
    }
}
counter+=0.1
if string_length(text[current])=0 {
    switch (side[current]){
        case(0):
            draw_sprite(s_arr,0,855,174+radtodeg(sin(counter))*0.15)
        break;
        case(1):
            draw_sprite(s_arr,0,268,626+radtodeg(sin(counter))*0.15)
        break;
    }
}
